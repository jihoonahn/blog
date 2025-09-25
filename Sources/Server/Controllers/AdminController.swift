import Vapor
import Fluent
import JWTKit

struct AdminController {
    func login(_ req: Request) async throws -> AdminLoginResponse {
        try AdminLoginRequest.validate(content: req)
        let loginData = try req.content.decode(AdminLoginRequest.self)
        
        guard let admin = try await Admin.query(on: req.db)
            .filter(\.$email == loginData.email)
            .first() else {
            throw Abort(.unauthorized, reason: "Wrong Email or Password")
        }
        
        guard try Bcrypt.verify(loginData.password, created: admin.passwordHash) else {
            throw Abort(.unauthorized, reason: "Wrong Email or Password")
        }
        
        let payload = AdminPayload(
            subject: SubjectClaim(value: "blog-admin"),
            expiration: ExpirationClaim(value: Date().addingTimeInterval(24 * 3600)),
            adminId: try admin.requireID()
        )

        guard let keys = req.application.jwtKeyCollection else {
            throw Abort(.internalServerError, reason: "Is not available JWT Tokens")
        }
        let token = try await keys.sign(payload)
        
        return AdminLoginResponse(
            admin: AdminResponse(from: admin),
            token: token
        )
    }
    
    func profile(_ req: Request) async throws -> AdminResponse {
        let admin = try req.requireAdmin()
        return AdminResponse(from: admin)
    }
    
    func refresh(_ req: Request) async throws -> AdminLoginResponse {
        let admin = try req.requireAdmin()
        
        let payload = AdminPayload(
            subject: SubjectClaim(value: "blog-admin"),
            expiration: ExpirationClaim(value: Date().addingTimeInterval(24 * 3600)),
            adminId: try admin.requireID()
        )

        guard let keys = req.application.jwtKeyCollection else {
            throw Abort(.internalServerError, reason: "Is not available JWT Tokens")
        }
        let token = try await keys.sign(payload)
        
        return AdminLoginResponse(
            admin: AdminResponse(from: admin),
            token: token
        )
    }
}
