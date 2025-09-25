import Vapor
import Fluent

struct CommentController {

    init() {}

    func byPost(_ req: Request) async throws -> [CommentResponse] {
        guard let post = try await Post.find(req.parameters.get("postID"), on: req.db) else {
            throw Abort(.notFound, reason: "Post Not Found")
        }
        
        let postID = try post.requireID()
        let comments = try await Comment.query(on: req.db)
            .filter(\.$post.$id == postID)
            .sort(\.$createdAt, .ascending)
            .all()
        
        return comments.map(CommentResponse.init)
    }
    
    func create(_ req: Request) async throws -> CommentResponse {
        guard let post = try await Post.find(req.parameters.get("postID"), on: req.db) else {
            throw Abort(.notFound, reason: "Post Not Found")
        }
        
        guard post.status == .published else {
            throw Abort(.forbidden, reason: "Can not write comment on un-published post")
        }
        
        try CreateCommentRequest.validate(content: req)
        let commentData = try req.content.decode(CreateCommentRequest.self)
        
        let authorIP = req.remoteAddress?.ipAddress ?? "unknown"
        
        let comment = Comment(
            name: commentData.name.trimmingCharacters(in: .whitespacesAndNewlines),
            message: commentData.message.trimmingCharacters(in: .whitespacesAndNewlines),
            authorIP: authorIP,
            postID: try post.requireID()
        )
        
        try await comment.save(on: req.db)
        
        return CommentResponse(from: comment)
    }
    
    func delete(_ req: Request) async throws -> HTTPStatus {
        let _ = try req.requireAdmin()
        
        guard let comment = try await Comment.find(req.parameters.get("commentID"), on: req.db) else {
            throw Abort(.notFound, reason: "Comment Not Found")
        }
        
        try await comment.delete(on: req.db)
        return .noContent
    }
}
