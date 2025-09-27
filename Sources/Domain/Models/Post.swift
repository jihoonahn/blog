import Foundation

public struct Post: Codable, Identifiable, Equatable, Sendable {
    public let id: UUID
    public let title: String
    public let content: String
    public let excerpt: String
    public let slug: String
    public let status: PostStatus
    public let publishedAt: Date?
    public let createdAt: Date
    public let updatedAt: Date
    public let authorId: UUID
    public let categoryId: UUID?
    public let tags: [Tag]
    public let featuredImage: String?
    public let viewCount: Int
    public let likeCount: Int
    
    public init(
        id: UUID = UUID(),
        title: String,
        content: String,
        excerpt: String,
        slug: String,
        status: PostStatus = .draft,
        publishedAt: Date? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        authorId: UUID,
        categoryId: UUID? = nil,
        tags: [Tag] = [],
        featuredImage: String? = nil,
        viewCount: Int = 0,
        likeCount: Int = 0
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.excerpt = excerpt
        self.slug = slug
        self.status = status
        self.publishedAt = publishedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.authorId = authorId
        self.categoryId = categoryId
        self.tags = tags
        self.featuredImage = featuredImage
        self.viewCount = viewCount
        self.likeCount = likeCount
    }
}

public enum PostStatus: String, Codable, CaseIterable, Sendable {
    case draft = "draft"
    case published = "published"
    case archived = "archived"
    
    public var displayName: String {
        switch self {
        case .draft: return "초안"
        case .published: return "발행됨"
        case .archived: return "보관됨"
        }
    }
}
