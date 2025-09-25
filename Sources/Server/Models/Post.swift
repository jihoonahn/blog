import Vapor
import Fluent

final class Post: Model, Content, @unchecked Sendable {
    static let schema = "posts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "content")
    var content: String
    
    @Field(key: "excerpt")
    var excerpt: String
    
    @Field(key: "slug")
    var slug: String
    
    @Field(key: "featured_image_url")
    var featuredImageURL: String?
    
    @Enum(key: "status")
    var status: PostStatus
    
    @Parent(key: "author_id")
    var author: Admin
    
    @Children(for: \.$post)
    var comments: [Comment]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "published_at", on: .none)
    var publishedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, title: String, content: String, excerpt: String, slug: String, featuredImageURL: String? = nil, status: PostStatus = .draft, authorID: UUID) {
        self.id = id
        self.title = title
        self.content = content
        self.excerpt = excerpt
        self.slug = slug
        self.featuredImageURL = featuredImageURL
        self.status = status
        self.$author.id = authorID
    }
}

// DTO
struct PostResponse: Content {
    let id: UUID
    let title: String
    let content: String
    let excerpt: String
    let slug: String
    let featuredImageURL: String?
    let status: PostStatus
    let author: AdminResponse
    let commentCount: Int?
    let createdAt: Date?
    let updatedAt: Date?
    let publishedAt: Date?
    
    init(from post: Post, commentCount: Int? = nil) {
        self.id = post.id!
        self.title = post.title
        self.content = post.content
        self.excerpt = post.excerpt
        self.slug = post.slug
        self.featuredImageURL = post.featuredImageURL
        self.status = post.status
        self.author = AdminResponse(from: post.author)
        self.commentCount = commentCount
        self.createdAt = post.createdAt
        self.updatedAt = post.updatedAt
        self.publishedAt = post.publishedAt
    }
}

struct CreatePostRequest: Content, Validatable {
    let title: String
    let content: String
    let excerpt: String
    let featuredImageURL: String?
    
    static func validations(_ validations: inout Validations) {
        validations.add("title", as: String.self, is: !.empty)
        validations.add("content", as: String.self, is: !.empty)
        validations.add("excerpt", as: String.self, is: !.empty && .count(...300))
    }
}

struct UpdatePostRequest: Content, Validatable {
    let title: String?
    let content: String?
    let excerpt: String?
    let featuredImageURL: String?
    
    static func validations(_ validations: inout Validations) {
        validations.add("title", as: String?.self, is: .nil || !.empty)
        validations.add("content", as: String?.self, is: .nil || !.empty)
        validations.add("excerpt", as: String?.self, is: .nil || (!.empty && .count(...300)))
    }
}

struct CreatePost: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("posts")
            .id()
            .field("title", .string, .required)
            .field("content", .string, .required)
            .field("excerpt", .string, .required)
            .field("slug", .string, .required)
            .field("featured_image_url", .string)
            .field("status", .string, .required)
            .field("author_id", .uuid, .required, .references("admins", "id"))
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("published_at", .datetime)
            .unique(on: "slug")
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("posts").delete()
    }
}
