import Vapor

extension Request {
    func requireAdmin() throws -> Admin {
        guard let admin = self.auth.get(Admin.self) else {
            throw Abort(.unauthorized, reason: "Need Admin Verfied")
        }
        return admin
    }
}
