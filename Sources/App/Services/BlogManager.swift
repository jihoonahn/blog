import Foundation
import Domain

public class BlogManager {
    private let blogService: BlogService
    private let adminService: AdminService
    private let commentService: CommentService
    private let authService: AuthService
    private let mockRepository: MockRepository
    
    public init(
        blogService: BlogService,
        adminService: AdminService,
        commentService: CommentService,
        authService: AuthService
    ) {
        self.blogService = blogService
        self.adminService = adminService
        self.commentService = commentService
        self.authService = authService
        self.mockRepository = MockRepository()
    }
    
    // MARK: - Public Blog Methods
    
    public func getBlogEntity() async throws -> BlogEntity {
        return try await blogService.getBlogEntity()
    }
    
    public func getPublishedPosts(page: Int = 1, limit: Int = 10) async throws -> PaginatedResult<Post> {
        do {
            return try await blogService.getPublishedPosts(page: page, limit: limit)
        } catch {
            // Supabase 연결 실패 시 Mock Data 사용
            let mockPosts = try await mockRepository.getAllPosts()
            let startIndex = (page - 1) * limit
            let endIndex = min(startIndex + limit, mockPosts.count)
            let paginatedPosts = Array(mockPosts[startIndex..<endIndex])
            
            let pagination = Pagination(
                page: page,
                limit: limit,
                total: mockPosts.count
            )
            return PaginatedResult(data: paginatedPosts, pagination: pagination)
        }
    }
    
    public func getPost(by slug: String) async throws -> Post? {
        return try await blogService.getPost(by: slug)
    }
    
    public func getPost(by id: UUID) async throws -> Post? {
        do {
            return try await blogService.getPost(by: id)
        } catch {
            // Supabase 연결 실패 시 Mock Data 사용
            return try await mockRepository.getPost(by: id)
        }
    }
    
    public func getPosts(by categorySlug: String) async throws -> [Post] {
        return try await blogService.getPosts(by: categorySlug)
    }
    
    
    public func searchPosts(query: String) async throws -> [Post] {
        return try await blogService.searchPosts(query: query)
    }
    
    public func getRecentPosts(limit: Int = 5) async throws -> [Post] {
        return try await blogService.getRecentPosts(limit: limit)
    }
    
    public func getPopularPosts(limit: Int = 5) async throws -> [Post] {
        return try await blogService.getPopularPosts(limit: limit)
    }
    
    public func getAllCategories() async throws -> [Domain.Category] {
        do {
            return try await blogService.getAllCategories()
        } catch {
            // Supabase 연결 실패 시 Mock Data 사용
            return try await mockRepository.getAllCategories()
        }
    }
    
    public func getAllTags() async throws -> [Tag] {
        do {
            return try await blogService.getAllTags()
        } catch {
            // Supabase 연결 실패 시 Mock Data 사용
            return try await mockRepository.getAllTags()
        }
    }
    
    public func getCategory(by slug: String) async throws -> Domain.Category? {
        return try await blogService.getCategory(by: slug)
    }
    
    public func getTag(by slug: String) async throws -> Tag? {
        return try await blogService.getTag(by: slug)
    }
    
    public func incrementViewCount(postId: UUID) async throws -> Bool {
        return try await blogService.incrementViewCount(postId: postId)
    }
    
    public func incrementLikeCount(postId: UUID) async throws -> Bool {
        return try await blogService.incrementLikeCount(postId: postId)
    }
    
    public func getBlogConfig() async throws -> BlogConfig? {
        do {
            return try await blogService.getBlogConfig()
        } catch {
            // Supabase 연결 실패 시 Mock Data 사용
            return try await mockRepository.getBlogConfig()
        }
    }
    
    // MARK: - Comment Methods
    
    public func createComment(_ comment: Comment) async throws -> Comment {
        return try await commentService.createComment(comment)
    }
    
    public func getComments(for postId: UUID) async throws -> [Comment] {
        do {
            return try await commentService.getComments(for: postId)
        } catch {
            // Supabase 연결 실패 시 Mock Data 사용
            return try await mockRepository.getComments(by: postId)
        }
    }
    
    public func getApprovedComments(for postId: UUID) async throws -> [Comment] {
        return try await commentService.getApprovedComments(for: postId)
    }
    
    public func getCommentStats() async throws -> CommentStats {
        return try await commentService.getCommentStats()
    }
    
    // MARK: - Admin Methods (requires authentication)
    
    public func login(username: String, password: String, rememberMe: Bool = false) async throws -> AuthResult {
        return try await authService.login(username: username, password: password, rememberMe: rememberMe)
    }
    
    public func logout(token: String) async throws -> Bool {
        return try await authService.logout(token: token)
    }
    
    public func validateSession(token: String) async throws -> AdminSession? {
        return try await authService.validateToken(token)
    }
    
    public func hasPermission(token: String, permission: AdminPermission) async throws -> Bool {
        return try await authService.hasPermission(token: token, permission: permission)
    }
    
    public func getDashboardStats(token: String) async throws -> BlogStats {
        guard try await authService.hasPermission(token: token, permission: .readPosts) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await adminService.getDashboardStats()
    }
    
    public func getPendingComments(token: String) async throws -> [Comment] {
        guard try await authService.hasPermission(token: token, permission: .manageComments) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await commentService.getPendingComments()
    }
    
    public func approveComment(id: UUID, token: String) async throws -> Bool {
        guard try await authService.hasPermission(token: token, permission: .manageComments) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await commentService.approveComment(id: id)
    }
    
    public func rejectComment(id: UUID, token: String) async throws -> Bool {
        guard try await authService.hasPermission(token: token, permission: .manageComments) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await commentService.rejectComment(id: id)
    }
    
    public func markCommentAsSpam(id: UUID, token: String) async throws -> Bool {
        guard try await authService.hasPermission(token: token, permission: .manageComments) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await commentService.markAsSpam(id: id)
    }
    
    public func deleteComment(id: UUID, token: String) async throws -> Bool {
        guard try await authService.hasPermission(token: token, permission: .manageComments) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await commentService.deleteComment(id: id)
    }
    
    public func bulkApproveComments(commentIds: [UUID], token: String) async throws -> Int {
        guard try await authService.hasPermission(token: token, permission: .manageComments) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await commentService.bulkApprove(commentIds: commentIds)
    }
    
    public func bulkRejectComments(commentIds: [UUID], token: String) async throws -> Int {
        guard try await authService.hasPermission(token: token, permission: .manageComments) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await commentService.bulkReject(commentIds: commentIds)
    }
    
    public func bulkMarkCommentsAsSpam(commentIds: [UUID], token: String) async throws -> Int {
        guard try await authService.hasPermission(token: token, permission: .manageComments) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await commentService.bulkMarkAsSpam(commentIds: commentIds)
    }
    
    // MARK: - System Methods
    
    public func getSystemHealth(token: String) async throws -> SystemHealth {
        guard try await authService.hasPermission(token: token, permission: .manageSettings) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await adminService.getSystemHealth()
    }
    
    public func cleanupExpiredSessions(token: String) async throws -> Int {
        guard try await authService.hasPermission(token: token, permission: .manageSettings) else {
            throw BlogManagerError.insufficientPermissions
        }
        
        return try await authService.cleanupExpiredSessions()
    }
}

// MARK: - BlogManagerError

public enum BlogManagerError: Error, LocalizedError {
    case insufficientPermissions
    case authenticationRequired
    case invalidToken
    case serviceUnavailable
    case dataNotFound
    case validationFailed(String)
    
    public var errorDescription: String? {
        switch self {
        case .insufficientPermissions: return "권한이 부족합니다"
        case .authenticationRequired: return "인증이 필요합니다"
        case .invalidToken: return "유효하지 않은 토큰입니다"
        case .serviceUnavailable: return "서비스를 사용할 수 없습니다"
        case .dataNotFound: return "데이터를 찾을 수 없습니다"
        case .validationFailed(let message): return "유효성 검사 실패: \(message)"
        }
    }
}