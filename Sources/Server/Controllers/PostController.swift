import Vapor
import Fluent

struct PostController {
    func adminIndex(_ req: Request) async throws -> [PostResponse] {
        let _ = try req.requireAdmin()
        
        let posts = try await Post.query(on: req.db)
            .with(\.$author)
            .sort(\.$createdAt, .descending)
            .all()
        
        return posts.map { PostResponse(from: $0) }
    }
    
    func publicIndex(_ req: Request) async throws -> [PostResponse] {
        let posts = try await Post.query(on: req.db)
            .with(\.$author)
            .filter(\.$status == .published)
            .sort(\.$publishedAt, .descending)
            .all()
        
        return posts.map { PostResponse(from: $0) }
    }
    
    // 포스트 상세 조회
    func show(_ req: Request) async throws -> PostResponse {
        guard let post = try await Post.find(req.parameters.get("postID"), on: req.db) else {
            throw Abort(.notFound, reason: "Post Not Found")
        }
        
        try await post.$author.load(on: req.db)
        return PostResponse(from: post)
    }
    
    // 슬러그로 포스트 조회 (공개용)
    func bySlug(_ req: Request) async throws -> PostResponse {
        guard let slug = req.parameters.get("slug") else {
            throw Abort(.badRequest, reason: "Need Slug")
        }
        
        guard let post = try await Post.query(on: req.db)
            .filter(\.$slug == slug)
            .filter(\.$status == .published)
            .with(\.$author)
            .first() else {
            throw Abort(.notFound, reason: "Post Not Found")
        }
        
        return PostResponse(from: post)
    }
    
    // 포스트 생성
    func create(_ req: Request) async throws -> PostResponse {
        let admin = try req.requireAdmin()
        
        try CreatePostRequest.validate(content: req)
        let postData = try req.content.decode(CreatePostRequest.self)
        
        let post = Post(
            title: postData.title,
            content: postData.content,
            excerpt: postData.excerpt,
            slug: postData.title.slug,
            featuredImageURL: postData.featuredImageURL,
            status: .draft,
            authorID: try admin.requireID()
        )
        
        try await post.save(on: req.db)
        try await post.$author.load(on: req.db)
        
        return PostResponse(from: post)
    }
    
    // 포스트 수정
    func update(_ req: Request) async throws -> PostResponse {
        let _ = try req.requireAdmin()
        
        guard let post = try await Post.find(req.parameters.get("postID"), on: req.db) else {
            throw Abort(.notFound, reason: "Post Not Found")
        }
        
        try UpdatePostRequest.validate(content: req)
        let updateData = try req.content.decode(UpdatePostRequest.self)
        
        if let title = updateData.title {
            post.title = title
            post.slug = title.slug
        }
        if let content = updateData.content {
            post.content = content
        }
        if let excerpt = updateData.excerpt {
            post.excerpt = excerpt
        }
        if let featuredImageURL = updateData.featuredImageURL {
            post.featuredImageURL = featuredImageURL
        }
        
        try await post.save(on: req.db)
        try await post.$author.load(on: req.db)
        
        return PostResponse(from: post)
    }
    
    // 포스트 삭제
    func delete(_ req: Request) async throws -> HTTPStatus {
        let _ = try req.requireAdmin()
        
        guard let post = try await Post.find(req.parameters.get("postID"), on: req.db) else {
            throw Abort(.notFound, reason: "Post Not Found")
        }
        
        try await post.delete(on: req.db)
        return .noContent
    }
    
    // 포스트 발행
    func publish(_ req: Request) async throws -> PostResponse {
        let _ = try req.requireAdmin()
        
        guard let post = try await Post.find(req.parameters.get("postID"), on: req.db) else {
            throw Abort(.notFound, reason: "Post Not Found")
        }
        
        post.status = .published
        post.publishedAt = Date()
        
        try await post.save(on: req.db)
        try await post.$author.load(on: req.db)
        
        return PostResponse(from: post)
    }
}
