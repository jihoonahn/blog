import Foundation

public struct Tag: Codable, Identifiable, Equatable, Sendable {
    public let id: UUID
    public let name: String
    public let slug: String
    public let color: String?
    public let description: String?
    public let createdAt: Date
    public let updatedAt: Date
    public let postCount: Int
    
    public init(
        id: UUID = UUID(),
        name: String,
        slug: String,
        color: String? = nil,
        description: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        postCount: Int = 0
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.color = color
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.postCount = postCount
    }
}
