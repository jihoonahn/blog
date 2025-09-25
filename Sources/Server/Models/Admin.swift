import Vapor
import Fluent
import JWTKit

final class Admin: Model, Content, Authenticatable, @unchecked Sendable {
    static let schema = "admins"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Field(key: "name")
    var name: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    // 관계
    @Children(for: \.$author)
    var posts: [Post]
    
    @Children(for: \.$uploader)
    var images: [Image]
    
    init() { }
    
    init(id: UUID? = nil, email: String, passwordHash: String, name: String) {
        self.id = id
        self.email = email
        self.passwordHash = passwordHash
        self.name = name
    }
}

struct AdminPayload: JWTPayload {
    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case adminId = "admin_id"
    }
    
    var subject: SubjectClaim
    var expiration: ExpirationClaim
    var adminId: UUID
    
    func verify(using algorithm: some JWTAlgorithm) async throws {
        try self.expiration.verifyNotExpired()
    }
}

// DTO
struct AdminResponse: Content {
    let id: UUID
    let email: String
    let name: String
    let createdAt: Date?
    
    init(from admin: Admin) {
        self.id = admin.id!
        self.email = admin.email
        self.name = admin.name
        self.createdAt = admin.createdAt
    }
}

struct AdminLoginRequest: Content, Validatable {
    let email: String
    let password: String
    
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: !.empty)
    }
}

struct AdminLoginResponse: Content {
    let admin: AdminResponse
    let token: String
}

// 마이그레이션
struct CreateAdmin: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("admins")
            .id()
            .field("email", .string, .required)
            .field("password_hash", .string, .required)
            .field("name", .string, .required)
            .field("created_at", .datetime)
            .unique(on: "email")
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("admins").delete()
    }
}
