import Foundation

// MARK: - Admin Service Protocol
public protocol AdminServiceProtocol {
    func login(username: String, password: String, rememberMe: Bool) async throws -> AdminLoginResponse
    func logout(token: String) async throws -> Bool
    func validateSession(token: String) async throws -> AdminSession?
    func refreshSession(token: String) async throws -> AdminSession?
    func hasPermission(adminId: UUID, permission: AdminPermission) async throws -> Bool
    func updateLastActivity(token: String) async throws -> Bool
}

// MARK: - Admin Management Protocol
public protocol AdminManagementProtocol {
    func createAdmin(_ admin: Admin, password: String) async throws -> Admin
    func updateAdmin(_ admin: Admin) async throws -> Admin
    func deleteAdmin(id: UUID) async throws -> Bool
    func getAllAdmins() async throws -> [Admin]
    func getAdmin(id: UUID) async throws -> Admin?
    func changePassword(adminId: UUID, oldPassword: String, newPassword: String) async throws -> Bool
    func resetPassword(adminId: UUID, newPassword: String) async throws -> Bool
}

// MARK: - Admin Dashboard Protocol
public protocol AdminDashboardProtocol {
    func getDashboardStats() async throws -> BlogStats
    func getRecentActivity(limit: Int) async throws -> [AdminActivity]
    func getSystemHealth() async throws -> SystemHealth
}

// MARK: - Admin Activity
public struct AdminActivity: Codable, Identifiable {
    public let id: UUID
    public let adminId: UUID
    public let action: AdminAction
    public let description: String
    public let metadata: [String: String]
    public let ipAddress: String?
    public let userAgent: String?
    public let createdAt: Date
    
    public init(
        id: UUID = UUID(),
        adminId: UUID,
        action: AdminAction,
        description: String,
        metadata: [String: String] = [:],
        ipAddress: String? = nil,
        userAgent: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.adminId = adminId
        self.action = action
        self.description = description
        self.metadata = metadata
        self.ipAddress = ipAddress
        self.userAgent = userAgent
        self.createdAt = createdAt
    }
}

public enum AdminAction: String, Codable, CaseIterable {
    case login = "login"
    case logout = "logout"
    case createPost = "create_post"
    case updatePost = "update_post"
    case deletePost = "delete_post"
    case approveComment = "approve_comment"
    case rejectComment = "reject_comment"
    case createCategory = "create_category"
    case updateCategory = "update_category"
    case deleteCategory = "delete_category"
    case createTag = "create_tag"
    case updateTag = "update_tag"
    case deleteTag = "delete_tag"
    case updateSettings = "update_settings"
    case createAdmin = "create_admin"
    case updateAdmin = "update_admin"
    case deleteAdmin = "delete_admin"
    
    public var displayName: String {
        switch self {
        case .login: return "로그인"
        case .logout: return "로그아웃"
        case .createPost: return "포스트 생성"
        case .updatePost: return "포스트 수정"
        case .deletePost: return "포스트 삭제"
        case .approveComment: return "댓글 승인"
        case .rejectComment: return "댓글 거부"
        case .createCategory: return "카테고리 생성"
        case .updateCategory: return "카테고리 수정"
        case .deleteCategory: return "카테고리 삭제"
        case .createTag: return "태그 생성"
        case .updateTag: return "태그 수정"
        case .deleteTag: return "태그 삭제"
        case .updateSettings: return "설정 업데이트"
        case .createAdmin: return "관리자 생성"
        case .updateAdmin: return "관리자 수정"
        case .deleteAdmin: return "관리자 삭제"
        }
    }
}

// MARK: - System Health
public struct SystemHealth: Codable {
    public let status: HealthStatus
    public let database: HealthCheck
    public let storage: HealthCheck
    public let memory: HealthCheck
    public let uptime: TimeInterval
    public let lastChecked: Date
    
    public init(
        status: HealthStatus,
        database: HealthCheck,
        storage: HealthCheck,
        memory: HealthCheck,
        uptime: TimeInterval,
        lastChecked: Date = Date()
    ) {
        self.status = status
        self.database = database
        self.storage = storage
        self.memory = memory
        self.uptime = uptime
        self.lastChecked = lastChecked
    }
}

public enum HealthStatus: String, Codable {
    case healthy = "healthy"
    case warning = "warning"
    case critical = "critical"
    
    public var displayName: String {
        switch self {
        case .healthy: return "정상"
        case .warning: return "경고"
        case .critical: return "위험"
        }
    }
}

public struct HealthCheck: Codable {
    public let status: HealthStatus
    public let message: String
    public let responseTime: TimeInterval?
    
    public init(
        status: HealthStatus,
        message: String,
        responseTime: TimeInterval? = nil
    ) {
        self.status = status
        self.message = message
        self.responseTime = responseTime
    }
}
