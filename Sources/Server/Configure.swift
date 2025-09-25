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
    let envEmail = Environment.get("ADMIN_EMAIL")
    let envPassword = Environment.get("ADMIN_PASSWORD")
    
    app.logger.info("Existing admin found: \(existingAdmin?.email ?? "none")")
    app.logger.info("Environment ADMIN_EMAIL: \(envEmail ?? "not set")")
    app.logger.info("Environment ADMIN_PASSWORD: \(envPassword != nil ? "set" : "not set")")
    
    if existingAdmin == nil {
        // 새로운 admin 생성
        let defaultEmail = envEmail ?? "admin@blog.com"
        let defaultPassword = envPassword ?? "admin123"
        
        app.logger.info("Creating admin with email: \(defaultEmail)")
        
        let passwordHash = try Bcrypt.hash(defaultPassword)
        
        let admin = Admin(email: defaultEmail, passwordHash: passwordHash, name: "Admin")
        try await admin.save(on: app.db)
        
        app.logger.info("Default Admin Account created: \(defaultEmail)")
    } else if let envEmail = envEmail, let envPassword = envPassword {
        // 환경 변수가 설정되어 있고 기존 admin이 있으면 업데이트
        if existingAdmin?.email != envEmail {
            app.logger.info("Updating existing admin from \(existingAdmin?.email ?? "unknown") to \(envEmail)")
            
            existingAdmin?.email = envEmail
            existingAdmin?.passwordHash = try Bcrypt.hash(envPassword)
            try await existingAdmin?.save(on: app.db)
            
            app.logger.info("Admin account updated to: \(envEmail)")
        }
    } else {
        app.logger.info("Admin already exists, skipping creation")
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
