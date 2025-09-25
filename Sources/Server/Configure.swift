import Vapor
import Fluent
import FluentPostgresDriver
import NIOSSL
import JWTKit

func configure(_ app: Application) async throws {
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith]
    )
    
    app.middleware.use(CORSMiddleware(configuration: corsConfiguration), at: .beginning)
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.routes.defaultMaxBodySize = "20mb"
    
    if let databaseURL = Environment.get("DATABASE_URL") {
        try app.databases.use(.postgres(url: databaseURL), as: .psql)
    } else {
        app.databases.use(.postgres(
            configuration: SQLPostgresConfiguration(
                hostname: Environment.get("DATABASE_HOST") ?? "localhost",
                port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 5432,
                username: Environment.get("DATABASE_USERNAME") ?? "postgres",
                password: Environment.get("DATABASE_PASSWORD") ?? "password",
                tls: .prefer(try NIOSSLContext(configuration: .clientDefault)))
        ), as: .psql)
    }
    
    let jwtSecret = Environment.get("JWT_SECRET") ?? "secret-key-change-in-production"
    let key = JWTKeyCollection()
    await key.add(hmac: HMACKey(stringLiteral: jwtSecret), digestAlgorithm: .sha256)
    app.jwtKeyCollection = key

    app.migrations.add(CreateAdmin())
    app.migrations.add(CreatePost())
    app.migrations.add(CreateImage())
    app.migrations.add(CreateComment())

    app.middleware.use(ErrorMiddleware.default(environment: app.environment))
    try routes(app)

    if app.environment == .development {
        try await app.autoMigrate()
        try await createDefaultAdmin(app)
    }
    try createUploadDirectories(app)
}


private func createDefaultAdmin(_ app: Application) async throws {
    let existingAdmin = try await Admin.query(on: app.db).first()
    
    if existingAdmin == nil {
        let defaultEmail = Environment.get("ADMIN_EMAIL") ?? "admin@blog.com"
        let defaultPassword = Environment.get("ADMIN_PASSWORD") ?? "admin123"
        let passwordHash = try Bcrypt.hash(defaultPassword)
        
        let admin = Admin(email: defaultEmail, passwordHash: passwordHash, name: "Admin")
        try await admin.save(on: app.db)
        
        app.logger.info("Default Admin Account: \(defaultEmail)")
    }
}

private func createUploadDirectories(_ app: Application) throws {
    let publicDir = app.directory.publicDirectory
    let fileManager = FileManager.default
    
    let directories = [
        publicDir + "uploads/featured/",
        publicDir + "uploads/content/"
    ]
    
    for directory in directories {
        if !fileManager.fileExists(atPath: directory) {
            try fileManager.createDirectory(atPath: directory, withIntermediateDirectories: true)
        }
    }
}
