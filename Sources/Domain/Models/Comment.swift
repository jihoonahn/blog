import Foundation

public struct Comment: Codable, Identifiable, Equatable, Sendable {
    public let id: UUID
    public let postId: UUID
    public let authorName: String
    public let authorEmail: String
    public let content: String
    public let status: CommentStatus
    public let createdAt: Date
    public let updatedAt: Date
    public let parentId: UUID?
    public let ipAddress: String?
    public let userAgent: String?
    
    public init(
        id: UUID = UUID(),
        postId: UUID,
        authorName: String,
        authorEmail: String,
        content: String,
        status: CommentStatus = .pending,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        parentId: UUID? = nil,
        ipAddress: String? = nil,
        userAgent: String? = nil
    ) {
        self.id = id
        self.postId = postId
        self.authorName = authorName
        self.authorEmail = authorEmail
        self.content = content
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.parentId = parentId
        self.ipAddress = ipAddress
        self.userAgent = userAgent
    }
}

public enum CommentStatus: String, Codable, CaseIterable, Sendable {
    case pending = "pending"
    case approved = "approved"
    case rejected = "rejected"
    case spam = "spam"
    
    public var displayName: String {
        switch self {
        case .pending: return "대기중"
        case .approved: return "승인됨"
        case .rejected: return "거부됨"
        case .spam: return "스팸"
        }
    }
}
