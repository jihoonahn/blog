import Foundation
import Domain

public class AdminService: AdminServiceProtocol, AdminManagementProtocol, AdminDashboardProtocol {
    private let adminRepository: AdminRepositoryProtocol
    private let sessionRepository: SessionRepositoryProtocol
    private let postRepository: PostRepositoryProtocol
    private let commentRepository: CommentRepositoryProtocol
    private let categoryRepository: CategoryRepositoryProtocol
    private let tagRepository: TagRepositoryProtocol
    
    public init(
        adminRepository: AdminRepositoryProtocol,
        sessionRepository: SessionRepositoryProtocol,
        postRepository: PostRepositoryProtocol,
        commentRepository: CommentRepositoryProtocol,
        categoryRepository: CategoryRepositoryProtocol,
        tagRepository: TagRepositoryProtocol
    ) {
        self.adminRepository = adminRepository
        self.sessionRepository = sessionRepository
        self.postRepository = postRepository
        self.commentRepository = commentRepository
        self.categoryRepository = categoryRepository
        self.tagRepository = tagRepository
    }
    
    // MARK: - AdminServiceProtocol
    
    public func login(username: String, password: String, rememberMe: Bool) async throws -> AdminLoginResponse {
        guard let admin = try await adminRepository.getAdminByUsername(username: username) else {
            return AdminLoginResponse(success: false, message: "사용자를 찾을 수 없습니다")
        }
        
        // TODO: Implement password verification
        let credentials = AdminCredentials(username: username, password: password, rememberMe: rememberMe)
        
        let sessionDuration: TimeInterval = rememberMe ? 30 * 24 * 60 * 60 : 24 * 60 * 60 // 30 days or 1 day
        let expiresAt = Date().addingTimeInterval(sessionDuration)
        let token = generateSessionToken()
        
        let session = AdminSession(
            adminId: admin.id,
            token: token,
            expiresAt: expiresAt
        )
        
        let createdSession = try await sessionRepository.createSession(session)
        try await adminRepository.updateLastLogin(adminId: admin.id)
        
        return AdminLoginResponse(success: true, session: createdSession)
    }
    
    public func logout(token: String) async throws -> Bool {
        return try await sessionRepository.deleteSession(token: token)
    }
    
    public func validateSession(token: String) async throws -> AdminSession? {
        guard let session = try await sessionRepository.getSession(by: token) else {
            return nil
        }
        
        if session.isExpired {
            try await sessionRepository.deleteSession(token: token)
            return nil
        }
        
        return session
    }
    
    public func refreshSession(token: String) async throws -> AdminSession? {
        guard let session = try await validateSession(token: token) else {
            return nil
        }
        
        let newExpiresAt = Date().addingTimeInterval(24 * 60 * 60) // 1 day
        let refreshedSession = AdminSession(
            id: session.id,
            adminId: session.adminId,
            token: session.token,
            expiresAt: newExpiresAt,
            createdAt: session.createdAt,
            updatedAt: Date(),
            ipAddress: session.ipAddress,
            userAgent: session.userAgent
        )
        
        return try await sessionRepository.updateSession(refreshedSession)
    }
    
    public func hasPermission(adminId: UUID, permission: AdminPermission) async throws -> Bool {
        guard let admin = try await adminRepository.getAdmin(by: adminId) else {
            return false
        }
        
        return admin.role.permissions.contains(permission)
    }
    
    public func updateLastActivity(token: String) async throws -> Bool {
        guard let session = try await sessionRepository.getSession(by: token) else {
            return false
        }
        
        let updatedSession = AdminSession(
            id: session.id,
            adminId: session.adminId,
            token: session.token,
            expiresAt: session.expiresAt,
            createdAt: session.createdAt,
            updatedAt: Date(),
            ipAddress: session.ipAddress,
            userAgent: session.userAgent
        )
        
        _ = try await sessionRepository.updateSession(updatedSession)
        return true
    }
    
    // MARK: - AdminManagementProtocol
    
    public func createAdmin(_ admin: Admin, password: String) async throws -> Admin {
        // TODO: Hash password before storing
        return try await adminRepository.createAdmin(admin)
    }
    
    public func updateAdmin(_ admin: Admin) async throws -> Admin {
        return try await adminRepository.updateAdmin(admin)
    }
    
    public func deleteAdmin(id: UUID) async throws -> Bool {
        return try await adminRepository.deleteAdmin(id: id)
    }
    
    public func getAllAdmins() async throws -> [Admin] {
        return try await adminRepository.getAllAdmins()
    }
    
    public func getAdmin(id: UUID) async throws -> Admin? {
        return try await adminRepository.getAdmin(by: id)
    }
    
    public func changePassword(adminId: UUID, oldPassword: String, newPassword: String) async throws -> Bool {
        // TODO: Implement password change logic
        return true
    }
    
    public func resetPassword(adminId: UUID, newPassword: String) async throws -> Bool {
        // TODO: Implement password reset logic
        return true
    }
    
    // MARK: - AdminDashboardProtocol
    
    public func getDashboardStats() async throws -> BlogStats {
        let allPosts = try await postRepository.getAllPosts()
        let publishedPosts = allPosts.filter { $0.status == .published }
        let draftPosts = allPosts.filter { $0.status == .draft }
        
        let allComments = try await commentRepository.getAllComments()
        let approvedComments = allComments.filter { $0.status == .approved }
        let pendingComments = allComments.filter { $0.status == .pending }
        
        let categories = try await categoryRepository.getAllCategories()
        let tags = try await tagRepository.getAllTags()
        
        let totalViews = allPosts.reduce(0) { $0 + $1.viewCount }
        let totalLikes = allPosts.reduce(0) { $0 + $1.likeCount }
        
        return BlogStats(
            totalPosts: allPosts.count,
            publishedPosts: publishedPosts.count,
            draftPosts: draftPosts.count,
            totalComments: allComments.count,
            approvedComments: approvedComments.count,
            pendingComments: pendingComments.count,
            totalCategories: categories.count,
            totalTags: tags.count,
            totalViews: totalViews,
            totalLikes: totalLikes
        )
    }
    
    public func getRecentActivity(limit: Int) async throws -> [AdminActivity] {
        // TODO: Implement activity tracking
        return []
    }
    
    public func getSystemHealth() async throws -> SystemHealth {
        // TODO: Implement system health checks
        return SystemHealth(
            status: .healthy,
            database: HealthCheck(status: .healthy, message: "데이터베이스 연결 정상"),
            storage: HealthCheck(status: .healthy, message: "스토리지 정상"),
            memory: HealthCheck(status: .healthy, message: "메모리 사용량 정상"),
            uptime: 0
        )
    }
    
    // MARK: - Private Methods
    
    private func generateSessionToken() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<64).map { _ in characters.randomElement()! })
    }
}
