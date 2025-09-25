import Vapor
import JWTKit

struct AdminAuthMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        guard let bearerToken = request.headers.bearerAuthorization?.token else {
            throw Abort(.unauthorized, reason: "Need Verified Token")
        }
        
        do {
            guard let keys = request.application.jwtKeyCollection else {
                throw Abort(.internalServerError, reason: "No Setting JWT Keys")
            }
            
            // JWT 토큰 검증
            let payload = try await keys.verify(bearerToken, as: AdminPayload.self)
            
            guard let admin = try await Admin.find(payload.adminId, on: request.db) else {
                throw Abort(.unauthorized, reason: "Not Available Admin")
            }
            
            request.auth.login(admin)
            return try await next.respond(to: request)
        } catch {
            print("JWT Error: \(error)")
            throw Abort(.unauthorized, reason: "Token is not available")
        }
    }
}
