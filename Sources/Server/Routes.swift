import Vapor

func routes(_ app: Application) throws {

    app.get("health") { req in
        return ["status": "ok", "timestamp": ISO8601DateFormatter().string(from: Date())]
    }

    let api = app.grouped("api", "v1")

    // === 어드민 라우트 ===
    let adminController = AdminController()
    let adminGroup = api.grouped("admin")

    // 어드민 로그인 (public)
    adminGroup.post("login", use: adminController.login)
    
    // 어드민 전용 라우트 (인증 필요)
    let adminProtected = adminGroup.grouped(AdminAuthMiddleware())
    adminProtected.get("profile", use: adminController.profile)
    adminProtected.post("refresh", use: adminController.refresh)
    
    // === 포스트 관리 (어드민만) ===
    let postController = PostController()
    let adminPosts = adminProtected.grouped("posts")
    adminPosts.get(use: postController.adminIndex)       // 모든 포스트 (초안 포함)
    adminPosts.post(use: postController.create)         // 포스트 생성
    adminPosts.get(":postID", use: postController.show) // 포스트 상세
    adminPosts.put(":postID", use: postController.update) // 포스트 수정
    adminPosts.delete(":postID", use: postController.delete) // 포스트 삭제
    adminPosts.post(":postID", "publish", use: postController.publish) // 발행
    
    // === 이미지 업로드 (어드민만) ===
    let imageController = ImageController()
    let adminImages = adminProtected.grouped("images")
    adminImages.post("upload", use: imageController.upload)
    adminImages.get("my", use: imageController.myImages)
    adminImages.delete(":imageID", use: imageController.delete)
    
    // === 공개 포스트 라우트 (사용자용) ===
    let publicPosts = api.grouped("posts")
    publicPosts.get(use: postController.publicIndex)     // 발행된 포스트만
    publicPosts.get(":slug", use: postController.bySlug) // 슬러그로 포스트 조회
    
    // === 댓글 라우트 (로그인 불필요) ===
    let commentController = CommentController()
    let comments = api.grouped("comments")
    comments.get("post", ":postID", use: commentController.byPost)    // 포스트별 댓글 목록
    comments.post("post", ":postID", use: commentController.create)   // 댓글 작성 (익명)
    
    // 어드민만 댓글 삭제 가능
    adminProtected.delete("comments", ":commentID", use: commentController.delete)
}
