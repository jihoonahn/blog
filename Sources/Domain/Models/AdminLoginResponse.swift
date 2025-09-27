import Foundation

public struct AdminLoginResponse: Codable, Equatable, Sendable {
    public let success: Bool
    public let session: AdminSession?
    public let message: String?
    public let requiresTwoFactor: Bool
    
    public init(
        success: Bool,
        session: AdminSession? = nil,
        message: String? = nil,
        requiresTwoFactor: Bool = false
    ) {
        self.success = success
        self.session = session
        self.message = message
        self.requiresTwoFactor = requiresTwoFactor
    }
}
