import Foundation

public struct Admin: Codable, Identifiable, Equatable, Sendable {
    public let id: UUID
    public let username: String
    public let email: String
    public let displayName: String
    public let avatar: String?
    public let role: AdminRole
    public let isActive: Bool
    public let lastLoginAt: Date?
    public let createdAt: Date
    public let updatedAt: Date
    
    public init(
        id: UUID = UUID(),
        username: String,
        email: String,
        displayName: String,
        avatar: String? = nil,
        role: AdminRole = .editor,
        isActive: Bool = true,
        lastLoginAt: Date? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.displayName = displayName
        self.avatar = avatar
        self.role = role
        self.isActive = isActive
        self.lastLoginAt = lastLoginAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

public enum AdminRole: String, Codable, CaseIterable, Sendable {
    case superAdmin = "super_admin"
    case admin = "admin"
    case editor = "editor"
    case author = "author"
    
    public var displayName: String {
        switch self {
        case .superAdmin: return "최고 관리자"
        case .admin: return "관리자"
        case .editor: return "편집자"
        case .author: return "작성자"
        }
    }
    
    public var permissions: [AdminPermission] {
        switch self {
        case .superAdmin:
            return AdminPermission.allCases
        case .admin:
            return [.readPosts, .writePosts, .deletePosts, .manageComments, .manageCategories, .manageTags, .readUsers]
        case .editor:
            return [.readPosts, .writePosts, .manageComments, .manageCategories, .manageTags]
        case .author:
            return [.readPosts, .writePosts]
        }
    }
}

public enum AdminPermission: String, CaseIterable {
    case readPosts = "read_posts"
    case writePosts = "write_posts"
    case deletePosts = "delete_posts"
    case manageComments = "manage_comments"
    case manageCategories = "manage_categories"
    case manageTags = "manage_tags"
    case readUsers = "read_users"
    case writeUsers = "write_users"
    case deleteUsers = "delete_users"
    case manageSettings = "manage_settings"
    
    public var displayName: String {
        switch self {
        case .readPosts: return "포스트 읽기"
        case .writePosts: return "포스트 작성"
        case .deletePosts: return "포스트 삭제"
        case .manageComments: return "댓글 관리"
        case .manageCategories: return "카테고리 관리"
        case .manageTags: return "태그 관리"
        case .readUsers: return "사용자 읽기"
        case .writeUsers: return "사용자 작성"
        case .deleteUsers: return "사용자 삭제"
        case .manageSettings: return "설정 관리"
        }
    }
}
