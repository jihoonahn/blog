import Foundation

public struct AdminSession: Codable, Identifiable, Equatable, Sendable {
    public let id: UUID
    public let adminId: UUID
    public let token: String
    public let expiresAt: Date
    public let createdAt: Date
    public let updatedAt: Date
    public let ipAddress: String?
    public let userAgent: String?
    
    public var isExpired: Bool {
        return Date() > expiresAt
    }
    
    public init(
        id: UUID = UUID(),
        adminId: UUID,
        token: String,
        expiresAt: Date,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        ipAddress: String? = nil,
        userAgent: String? = nil
    ) {
        self.id = id
        self.adminId = adminId
        self.token = token
        self.expiresAt = expiresAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.ipAddress = ipAddress
        self.userAgent = userAgent
    }
}
