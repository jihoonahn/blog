import Foundation

public struct Category: Codable, Identifiable, Equatable, Sendable {
    public let id: UUID
    public let name: String
    public let slug: String
    public let description: String?
    public let color: String?
    public let icon: String?
    public let parentId: UUID?
    public let createdAt: Date
    public let updatedAt: Date
    public let postCount: Int
    
    public init(
        id: UUID = UUID(),
        name: String,
        slug: String,
        description: String? = nil,
        color: String? = nil,
        icon: String? = nil,
        parentId: UUID? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        postCount: Int = 0
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.description = description
        self.color = color
        self.icon = icon
        self.parentId = parentId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.postCount = postCount
    }
}
