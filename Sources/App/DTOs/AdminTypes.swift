import Foundation

// MARK: - Admin DTOs

public struct AdminDTO: Codable {
    public let id: String
    public let username: String
    public let email: String
    public let displayName: String
    public let avatar: String?
    public let role: String
    public let isActive: Bool
    public let lastLoginAt: Date?
    public let createdAt: Date
    public let updatedAt: Date
    public let permissions: [String]
    
    public init(
        id: String,
        username: String,
        email: String,
        displayName: String,
        avatar: String? = nil,
        role: String,
        isActive: Bool = true,
        lastLoginAt: Date? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        permissions: [String] = []
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
        self.permissions = permissions
    }
}

public struct AdminSessionDTO: Codable {
    public let token: String
    public let admin: AdminDTO
    public let expiresAt: Date
    public let createdAt: Date
    public let lastActivityAt: Date
    public let ipAddress: String?
    public let userAgent: String?
    public let isExpired: Bool
    public let isActive: Bool
    
    public init(
        token: String,
        admin: AdminDTO,
        expiresAt: Date,
        createdAt: Date = Date(),
        lastActivityAt: Date = Date(),
        ipAddress: String? = nil,
        userAgent: String? = nil,
        isExpired: Bool = false,
        isActive: Bool = true
    ) {
        self.token = token
        self.admin = admin
        self.expiresAt = expiresAt
        self.createdAt = createdAt
        self.lastActivityAt = lastActivityAt
        self.ipAddress = ipAddress
        self.userAgent = userAgent
        self.isExpired = isExpired
        self.isActive = isActive
    }
}

// MARK: - Admin Request DTOs

public struct AdminLoginRequestDTO: Codable {
    public let username: String
    public let password: String
    public let rememberMe: Bool
    public let ipAddress: String?
    public let userAgent: String?
    
    public init(
        username: String,
        password: String,
        rememberMe: Bool = false,
        ipAddress: String? = nil,
        userAgent: String? = nil
    ) {
        self.username = username
        self.password = password
        self.rememberMe = rememberMe
        self.ipAddress = ipAddress
        self.userAgent = userAgent
    }
}

public struct AdminLoginResponseDTO: Codable {
    public let success: Bool
    public let session: AdminSessionDTO?
    public let message: String?
    public let requiresTwoFactor: Bool
    public let token: String?
    
    public init(
        success: Bool,
        session: AdminSessionDTO? = nil,
        message: String? = nil,
        requiresTwoFactor: Bool = false,
        token: String? = nil
    ) {
        self.success = success
        self.session = session
        self.message = message
        self.requiresTwoFactor = requiresTwoFactor
        self.token = token
    }
}

public struct AdminRegistrationRequestDTO: Codable {
    public let username: String
    public let email: String
    public let password: String
    public let confirmPassword: String
    public let displayName: String
    public let role: String
    public let inviteCode: String?
    
    public init(
        username: String,
        email: String,
        password: String,
        confirmPassword: String,
        displayName: String,
        role: String = "editor",
        inviteCode: String? = nil
    ) {
        self.username = username
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.displayName = displayName
        self.role = role
        self.inviteCode = inviteCode
    }
}

public struct AdminUpdateRequestDTO: Codable {
    public let username: String?
    public let email: String?
    public let displayName: String?
    public let avatar: String?
    public let role: String?
    public let isActive: Bool?
    
    public init(
        username: String? = nil,
        email: String? = nil,
        displayName: String? = nil,
        avatar: String? = nil,
        role: String? = nil,
        isActive: Bool? = nil
    ) {
        self.username = username
        self.email = email
        self.displayName = displayName
        self.avatar = avatar
        self.role = role
        self.isActive = isActive
    }
}

public struct PasswordChangeRequestDTO: Codable {
    public let currentPassword: String
    public let newPassword: String
    public let confirmPassword: String
    
    public init(
        currentPassword: String,
        newPassword: String,
        confirmPassword: String
    ) {
        self.currentPassword = currentPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
    }
}

public struct PasswordResetRequestDTO: Codable {
    public let email: String
    
    public init(email: String) {
        self.email = email
    }
}

public struct PasswordResetConfirmDTO: Codable {
    public let token: String
    public let newPassword: String
    public let confirmPassword: String
    
    public init(
        token: String,
        newPassword: String,
        confirmPassword: String
    ) {
        self.token = token
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
    }
}

// MARK: - Admin Activity DTOs

public struct AdminActivityDTO: Codable {
    public let id: String
    public let adminId: String
    public let adminName: String
    public let action: String
    public let description: String
    public let metadata: [String: String]
    public let ipAddress: String?
    public let userAgent: String?
    public let createdAt: Date
    
    public init(
        id: String,
        adminId: String,
        adminName: String,
        action: String,
        description: String,
        metadata: [String: String] = [:],
        ipAddress: String? = nil,
        userAgent: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.adminId = adminId
        self.adminName = adminName
        self.action = action
        self.description = description
        self.metadata = metadata
        self.ipAddress = ipAddress
        self.userAgent = userAgent
        self.createdAt = createdAt
    }
}

public struct AdminActivityListResponseDTO: Codable {
    public let activities: [AdminActivityDTO]
    public let pagination: PaginationInfo
    public let totalCount: Int
    public let dateRange: DateRangeDTO?
    
    public init(
        activities: [AdminActivityDTO],
        pagination: PaginationInfo,
        totalCount: Int,
        dateRange: DateRangeDTO? = nil
    ) {
        self.activities = activities
        self.pagination = pagination
        self.totalCount = totalCount
        self.dateRange = dateRange
    }
}

public struct DateRangeDTO: Codable {
    public let startDate: Date
    public let endDate: Date
    
    public init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
}

// MARK: - Admin Permission DTOs

public struct AdminPermissionDTO: Codable {
    public let name: String
    public let displayName: String
    public let description: String
    public let category: String
    
    public init(
        name: String,
        displayName: String,
        description: String,
        category: String
    ) {
        self.name = name
        self.displayName = displayName
        self.description = description
        self.category = category
    }
}

public struct AdminRoleDTO: Codable {
    public let name: String
    public let displayName: String
    public let description: String
    public let permissions: [AdminPermissionDTO]
    public let isSystemRole: Bool
    public let canBeDeleted: Bool
    
    public init(
        name: String,
        displayName: String,
        description: String,
        permissions: [AdminPermissionDTO],
        isSystemRole: Bool = false,
        canBeDeleted: Bool = true
    ) {
        self.name = name
        self.displayName = displayName
        self.description = description
        self.permissions = permissions
        self.isSystemRole = isSystemRole
        self.canBeDeleted = canBeDeleted
    }
}

// MARK: - Admin Dashboard DTOs

public struct AdminDashboardDTO: Codable {
    public let stats: BlogStatsDTO
    public let recentActivity: [AdminActivityDTO]
    public let systemHealth: SystemHealthDTO
    public let pendingTasks: [PendingTaskDTO]
    public let notifications: [NotificationDTO]
    public let quickActions: [QuickActionDTO]
    
    public init(
        stats: BlogStatsDTO,
        recentActivity: [AdminActivityDTO],
        systemHealth: SystemHealthDTO,
        pendingTasks: [PendingTaskDTO],
        notifications: [NotificationDTO],
        quickActions: [QuickActionDTO]
    ) {
        self.stats = stats
        self.recentActivity = recentActivity
        self.systemHealth = systemHealth
        self.pendingTasks = pendingTasks
        self.notifications = notifications
        self.quickActions = quickActions
    }
}

public struct PendingTaskDTO: Codable {
    public let id: String
    public let type: String
    public let title: String
    public let description: String
    public let priority: String
    public let createdAt: Date
    public let dueDate: Date?
    public let assignedTo: String?
    
    public init(
        id: String,
        type: String,
        title: String,
        description: String,
        priority: String,
        createdAt: Date = Date(),
        dueDate: Date? = nil,
        assignedTo: String? = nil
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.description = description
        self.priority = priority
        self.createdAt = createdAt
        self.dueDate = dueDate
        self.assignedTo = assignedTo
    }
}

public struct NotificationDTO: Codable {
    public let id: String
    public let type: String
    public let title: String
    public let message: String
    public let isRead: Bool
    public let createdAt: Date
    public let actionUrl: String?
    public let actionText: String?
    
    public init(
        id: String,
        type: String,
        title: String,
        message: String,
        isRead: Bool = false,
        createdAt: Date = Date(),
        actionUrl: String? = nil,
        actionText: String? = nil
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.message = message
        self.isRead = isRead
        self.createdAt = createdAt
        self.actionUrl = actionUrl
        self.actionText = actionText
    }
}

public struct QuickActionDTO: Codable {
    public let id: String
    public let title: String
    public let description: String
    public let icon: String
    public let url: String
    public let color: String
    public let requiresPermission: String?
    
    public init(
        id: String,
        title: String,
        description: String,
        icon: String,
        url: String,
        color: String,
        requiresPermission: String? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.icon = icon
        self.url = url
        self.color = color
        self.requiresPermission = requiresPermission
    }
}

// MARK: - Admin Settings DTOs

public struct AdminSettingsDTO: Codable {
    public let general: GeneralSettingsDTO
    public let security: SecuritySettingsDTO
    public let notifications: NotificationSettingsDTO
    public let appearance: AppearanceSettingsDTO
    public let advanced: AdvancedSettingsDTO
    
    public init(
        general: GeneralSettingsDTO,
        security: SecuritySettingsDTO,
        notifications: NotificationSettingsDTO,
        appearance: AppearanceSettingsDTO,
        advanced: AdvancedSettingsDTO
    ) {
        self.general = general
        self.security = security
        self.notifications = notifications
        self.appearance = appearance
        self.advanced = advanced
    }
}

public struct GeneralSettingsDTO: Codable {
    public let siteName: String
    public let siteDescription: String
    public let siteUrl: String
    public let adminEmail: String
    public let timezone: String
    public let language: String
    public let dateFormat: String
    public let timeFormat: String
    
    public init(
        siteName: String,
        siteDescription: String,
        siteUrl: String,
        adminEmail: String,
        timezone: String,
        language: String,
        dateFormat: String,
        timeFormat: String
    ) {
        self.siteName = siteName
        self.siteDescription = siteDescription
        self.siteUrl = siteUrl
        self.adminEmail = adminEmail
        self.timezone = timezone
        self.language = language
        self.dateFormat = dateFormat
        self.timeFormat = timeFormat
    }
}

public struct SecuritySettingsDTO: Codable {
    public let requireTwoFactor: Bool
    public let sessionTimeout: Int
    public let maxLoginAttempts: Int
    public let lockoutDuration: Int
    public let passwordMinLength: Int
    public let passwordRequireSpecialChars: Bool
    public let allowedIpAddresses: [String]
    
    public init(
        requireTwoFactor: Bool,
        sessionTimeout: Int,
        maxLoginAttempts: Int,
        lockoutDuration: Int,
        passwordMinLength: Int,
        passwordRequireSpecialChars: Bool,
        allowedIpAddresses: [String]
    ) {
        self.requireTwoFactor = requireTwoFactor
        self.sessionTimeout = sessionTimeout
        self.maxLoginAttempts = maxLoginAttempts
        self.lockoutDuration = lockoutDuration
        self.passwordMinLength = passwordMinLength
        self.passwordRequireSpecialChars = passwordRequireSpecialChars
        self.allowedIpAddresses = allowedIpAddresses
    }
}

public struct NotificationSettingsDTO: Codable {
    public let emailNotifications: Bool
    public let newCommentNotification: Bool
    public let newUserNotification: Bool
    public let systemAlertNotification: Bool
    public let weeklyReportNotification: Bool
    public let notificationEmail: String
    
    public init(
        emailNotifications: Bool,
        newCommentNotification: Bool,
        newUserNotification: Bool,
        systemAlertNotification: Bool,
        weeklyReportNotification: Bool,
        notificationEmail: String
    ) {
        self.emailNotifications = emailNotifications
        self.newCommentNotification = newCommentNotification
        self.newUserNotification = newUserNotification
        self.systemAlertNotification = systemAlertNotification
        self.weeklyReportNotification = weeklyReportNotification
        self.notificationEmail = notificationEmail
    }
}

public struct AppearanceSettingsDTO: Codable {
    public let theme: String
    public let primaryColor: String
    public let secondaryColor: String
    public let logo: String?
    public let favicon: String?
    public let customCss: String?
    
    public init(
        theme: String,
        primaryColor: String,
        secondaryColor: String,
        logo: String? = nil,
        favicon: String? = nil,
        customCss: String? = nil
    ) {
        self.theme = theme
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.logo = logo
        self.favicon = favicon
        self.customCss = customCss
    }
}

public struct AdvancedSettingsDTO: Codable {
    public let debugMode: Bool
    public let maintenanceMode: Bool
    public let cacheEnabled: Bool
    public let cacheDuration: Int
    public let apiRateLimit: Int
    public let maxFileUploadSize: Int
    public let allowedFileTypes: [String]
    
    public init(
        debugMode: Bool,
        maintenanceMode: Bool,
        cacheEnabled: Bool,
        cacheDuration: Int,
        apiRateLimit: Int,
        maxFileUploadSize: Int,
        allowedFileTypes: [String]
    ) {
        self.debugMode = debugMode
        self.maintenanceMode = maintenanceMode
        self.cacheEnabled = cacheEnabled
        self.cacheDuration = cacheDuration
        self.apiRateLimit = apiRateLimit
        self.maxFileUploadSize = maxFileUploadSize
        self.allowedFileTypes = allowedFileTypes
    }
}
