import Vapor
import Fluent

final class Comment: Model, Content, @unchecked Sendable {
    static let schema = "comments"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "message")
    var message: String
    
    @Field(key: "author_ip")
    var authorIP: String
    
    @Parent(key: "post_id")
    var post: Post
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, name: String, message: String, authorIP: String, postID: UUID) {
        self.id = id
        self.name = name
        self.message = message
        self.authorIP = authorIP
        self.$post.id = postID
    }
}

// DTO
struct CommentResponse: Content {
    let id: UUID
    let name: String
    let message: String
    let createdAt: Date?
    
    init(from comment: Comment) {
        self.id = comment.id!
        self.name = comment.name
        self.message = comment.message
        self.createdAt = comment.createdAt
    }
}

struct CreateCommentRequest: Content, Validatable {
    let name: String
    let message: String
    
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: !.empty && .count(...50))
        validations.add("message", as: String.self, is: !.empty && .count(...1000))
    }
}

// 마이그레이션
struct CreateComment: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("comments")
            .id()
            .field("name", .string, .required)
            .field("message", .string, .required)
            .field("author_ip", .string, .required)
            .field("post_id", .uuid, .required, .references("posts", "id", onDelete: .cascade))
            .field("created_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("comments").delete()
    }
}
