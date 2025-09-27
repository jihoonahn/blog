import Foundation

// MARK: - Comment DTOs

public struct CommentDTO: Codable {
    public let id: String
    public let postId: String
    public let authorName: String
    public let authorEmail: String
    public let content: String
    public let status: String
    public let createdAt: Date
    public let updatedAt: Date
    public let parentId: String?
    public let ipAddress: String?
    public let userAgent: String?
    public let website: String?
    public let avatar: String?
    public let replies: [CommentDTO]?
    public let likeCount: Int
    public let isLiked: Bool?
    
    public init(
        id: String,
        postId: String,
        authorName: String,
        authorEmail: String,
        content: String,
        status: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        parentId: String? = nil,
        ipAddress: String? = nil,
        userAgent: String? = nil,
        website: String? = nil,
        avatar: String? = nil,
        replies: [CommentDTO]? = nil,
        likeCount: Int = 0,
        isLiked: Bool? = nil
    ) {
        self.id = id
        self.postId = postId
        self.authorName = authorName
        self.authorEmail = authorEmail
        self.content = content
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.parentId = parentId
        self.ipAddress = ipAddress
        self.userAgent = userAgent
        self.website = website
        self.avatar = avatar
        self.replies = replies
        self.likeCount = likeCount
        self.isLiked = isLiked
    }
}

// MARK: - Comment Request DTOs

public struct CommentSubmitRequestDTO: Codable {
    public let postId: String
    public let authorName: String
    public let authorEmail: String
    public let content: String
    public let parentId: String?
    public let website: String?
    public let notifyOnReply: Bool
    public let captchaToken: String?
    
    public init(
        postId: String,
        authorName: String,
        authorEmail: String,
        content: String,
        parentId: String? = nil,
        website: String? = nil,
        notifyOnReply: Bool = false,
        captchaToken: String? = nil
    ) {
        self.postId = postId
        self.authorName = authorName
        self.authorEmail = authorEmail
        self.content = content
        self.parentId = parentId
        self.website = website
        self.notifyOnReply = notifyOnReply
        self.captchaToken = captchaToken
    }
}

public struct CommentUpdateRequestDTO: Codable {
    public let content: String?
    public let status: String?
    public let authorName: String?
    public let authorEmail: String?
    public let website: String?
    
    public init(
        content: String? = nil,
        status: String? = nil,
        authorName: String? = nil,
        authorEmail: String? = nil,
        website: String? = nil
    ) {
        self.content = content
        self.status = status
        self.authorName = authorName
        self.authorEmail = authorEmail
        self.website = website
    }
}

public struct CommentModerationRequestDTO: Codable {
    public let action: String
    public let reason: String?
    public let notifyAuthor: Bool
    public let customMessage: String?
    
    public init(
        action: String,
        reason: String? = nil,
        notifyAuthor: Bool = false,
        customMessage: String? = nil
    ) {
        self.action = action
        self.reason = reason
        self.notifyAuthor = notifyAuthor
        self.customMessage = customMessage
    }
}

public struct BulkCommentActionRequestDTO: Codable {
    public let commentIds: [String]
    public let action: String
    public let reason: String?
    public let notifyAuthors: Bool
    public let customMessage: String?
    
    public init(
        commentIds: [String],
        action: String,
        reason: String? = nil,
        notifyAuthors: Bool = false,
        customMessage: String? = nil
    ) {
        self.commentIds = commentIds
        self.action = action
        self.reason = reason
        self.notifyAuthors = notifyAuthors
        self.customMessage = customMessage
    }
}

// MARK: - Comment Response DTOs

public struct CommentSubmitResponseDTO: Codable {
    public let success: Bool
    public let comment: CommentDTO?
    public let message: String
    public let requiresModeration: Bool
    public let estimatedApprovalTime: String?
    public let captchaRequired: Bool
    public let captchaSiteKey: String?
    
    public init(
        success: Bool,
        comment: CommentDTO? = nil,
        message: String,
        requiresModeration: Bool,
        estimatedApprovalTime: String? = nil,
        captchaRequired: Bool = false,
        captchaSiteKey: String? = nil
    ) {
        self.success = success
        self.comment = comment
        self.message = message
        self.requiresModeration = requiresModeration
        self.estimatedApprovalTime = estimatedApprovalTime
        self.captchaRequired = captchaRequired
        self.captchaSiteKey = captchaSiteKey
    }
}

public struct CommentListResponseDTO: Codable {
    public let comments: [CommentDTO]
    public let pagination: PaginationInfo
    public let totalCount: Int
    public let statusCounts: CommentStatusCountsDTO
    public let filters: CommentFiltersDTO
    
    public init(
        comments: [CommentDTO],
        pagination: PaginationInfo,
        totalCount: Int,
        statusCounts: CommentStatusCountsDTO,
        filters: CommentFiltersDTO
    ) {
        self.comments = comments
        self.pagination = pagination
        self.totalCount = totalCount
        self.statusCounts = statusCounts
        self.filters = filters
    }
}

public struct CommentStatusCountsDTO: Codable {
    public let total: Int
    public let approved: Int
    public let pending: Int
    public let rejected: Int
    public let spam: Int
    
    public init(
        total: Int,
        approved: Int,
        pending: Int,
        rejected: Int,
        spam: Int
    ) {
        self.total = total
        self.approved = approved
        self.pending = pending
        self.rejected = rejected
        self.spam = spam
    }
}

public struct CommentFiltersDTO: Codable {
    public let status: String?
    public let postId: String?
    public let authorEmail: String?
    public let dateFrom: Date?
    public let dateTo: Date?
    public let search: String?
    
    public init(
        status: String? = nil,
        postId: String? = nil,
        authorEmail: String? = nil,
        dateFrom: Date? = nil,
        dateTo: Date? = nil,
        search: String? = nil
    ) {
        self.status = status
        self.postId = postId
        self.authorEmail = authorEmail
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.search = search
    }
}

// MARK: - Comment Moderation DTOs

public struct CommentModerationQueueDTO: Codable {
    public let pendingComments: [CommentDTO]
    public let totalPending: Int
    public let averageWaitTime: String?
    public let lastModeratedAt: Date?
    public let moderationStats: CommentModerationStatsDTO
    
    public init(
        pendingComments: [CommentDTO],
        totalPending: Int,
        averageWaitTime: String? = nil,
        lastModeratedAt: Date? = nil,
        moderationStats: CommentModerationStatsDTO
    ) {
        self.pendingComments = pendingComments
        self.totalPending = totalPending
        self.averageWaitTime = averageWaitTime
        self.lastModeratedAt = lastModeratedAt
        self.moderationStats = moderationStats
    }
}

public struct CommentModerationStatsDTO: Codable {
    public let totalModerated: Int
    public let approvedCount: Int
    public let rejectedCount: Int
    public let spamCount: Int
    public let averageModerationTime: String?
    public let moderationRate: Double
    public let spamRate: Double
    
    public init(
        totalModerated: Int,
        approvedCount: Int,
        rejectedCount: Int,
        spamCount: Int,
        averageModerationTime: String? = nil,
        moderationRate: Double,
        spamRate: Double
    ) {
        self.totalModerated = totalModerated
        self.approvedCount = approvedCount
        self.rejectedCount = rejectedCount
        self.spamCount = spamCount
        self.averageModerationTime = averageModerationTime
        self.moderationRate = moderationRate
        self.spamRate = spamRate
    }
}

public struct CommentSpamCheckDTO: Codable {
    public let isSpam: Bool
    public let confidence: Double
    public let reasons: [String]
    public let score: Int
    public let suggestions: [String]
    
    public init(
        isSpam: Bool,
        confidence: Double,
        reasons: [String],
        score: Int,
        suggestions: [String]
    ) {
        self.isSpam = isSpam
        self.confidence = confidence
        self.reasons = reasons
        self.score = score
        self.suggestions = suggestions
    }
}

// MARK: - Comment Settings DTOs

public struct CommentSettingsDTO: Codable {
    public let allowComments: Bool
    public let moderateComments: Bool
    public let requireApproval: Bool
    public let allowNestedComments: Bool
    public let maxNestingLevel: Int
    public let allowGuestComments: Bool
    public let requireEmail: Bool
    public let requireName: Bool
    public let allowHtml: Bool
    public let maxLength: Int
    public let minLength: Int
    public let autoCloseComments: Bool
    public let autoCloseDays: Int
    public let enableCaptcha: Bool
    public let captchaProvider: String?
    public let captchaSiteKey: String?
    public let enableAkismet: Bool
    public let akismetApiKey: String?
    public let enableModeration: Bool
    public let moderationKeywords: [String]
    public let blacklistedDomains: [String]
    public let whitelistedDomains: [String]
    
    public init(
        allowComments: Bool,
        moderateComments: Bool,
        requireApproval: Bool,
        allowNestedComments: Bool,
        maxNestingLevel: Int,
        allowGuestComments: Bool,
        requireEmail: Bool,
        requireName: Bool,
        allowHtml: Bool,
        maxLength: Int,
        minLength: Int,
        autoCloseComments: Bool,
        autoCloseDays: Int,
        enableCaptcha: Bool,
        captchaProvider: String? = nil,
        captchaSiteKey: String? = nil,
        enableAkismet: Bool,
        akismetApiKey: String? = nil,
        enableModeration: Bool,
        moderationKeywords: [String],
        blacklistedDomains: [String],
        whitelistedDomains: [String]
    ) {
        self.allowComments = allowComments
        self.moderateComments = moderateComments
        self.requireApproval = requireApproval
        self.allowNestedComments = allowNestedComments
        self.maxNestingLevel = maxNestingLevel
        self.allowGuestComments = allowGuestComments
        self.requireEmail = requireEmail
        self.requireName = requireName
        self.allowHtml = allowHtml
        self.maxLength = maxLength
        self.minLength = minLength
        self.autoCloseComments = autoCloseComments
        self.autoCloseDays = autoCloseDays
        self.enableCaptcha = enableCaptcha
        self.captchaProvider = captchaProvider
        self.captchaSiteKey = captchaSiteKey
        self.enableAkismet = enableAkismet
        self.akismetApiKey = akismetApiKey
        self.enableModeration = enableModeration
        self.moderationKeywords = moderationKeywords
        self.blacklistedDomains = blacklistedDomains
        self.whitelistedDomains = whitelistedDomains
    }
}

// MARK: - Comment Notification DTOs

public struct CommentNotificationDTO: Codable {
    public let id: String
    public let type: String
    public let commentId: String
    public let postId: String
    public let postTitle: String
    public let authorName: String
    public let content: String
    public let status: String
    public let createdAt: Date
    public let isRead: Bool
    public let actionUrl: String
    
    public init(
        id: String,
        type: String,
        commentId: String,
        postId: String,
        postTitle: String,
        authorName: String,
        content: String,
        status: String,
        createdAt: Date = Date(),
        isRead: Bool = false,
        actionUrl: String
    ) {
        self.id = id
        self.type = type
        self.commentId = commentId
        self.postId = postId
        self.postTitle = postTitle
        self.authorName = authorName
        self.content = content
        self.status = status
        self.createdAt = createdAt
        self.isRead = isRead
        self.actionUrl = actionUrl
    }
}

// MARK: - Comment Analytics DTOs

public struct CommentAnalyticsDTO: Codable {
    public let totalComments: Int
    public let commentsToday: Int
    public let commentsThisWeek: Int
    public let commentsThisMonth: Int
    public let averageCommentsPerPost: Double
    public let mostCommentedPosts: [PostCommentCountDTO]
    public let commentTrends: [CommentTrendDTO]
    public let topCommenters: [CommenterStatsDTO]
    public let commentSources: [CommentSourceDTO]
    
    public init(
        totalComments: Int,
        commentsToday: Int,
        commentsThisWeek: Int,
        commentsThisMonth: Int,
        averageCommentsPerPost: Double,
        mostCommentedPosts: [PostCommentCountDTO],
        commentTrends: [CommentTrendDTO],
        topCommenters: [CommenterStatsDTO],
        commentSources: [CommentSourceDTO]
    ) {
        self.totalComments = totalComments
        self.commentsToday = commentsToday
        self.commentsThisWeek = commentsThisWeek
        self.commentsThisMonth = commentsThisMonth
        self.averageCommentsPerPost = averageCommentsPerPost
        self.mostCommentedPosts = mostCommentedPosts
        self.commentTrends = commentTrends
        self.topCommenters = topCommenters
        self.commentSources = commentSources
    }
}

public struct PostCommentCountDTO: Codable {
    public let postId: String
    public let postTitle: String
    public let commentCount: Int
    public let url: String
    
    public init(
        postId: String,
        postTitle: String,
        commentCount: Int,
        url: String
    ) {
        self.postId = postId
        self.postTitle = postTitle
        self.commentCount = commentCount
        self.url = url
    }
}

public struct CommentTrendDTO: Codable {
    public let date: Date
    public let count: Int
    public let approved: Int
    public let pending: Int
    public let rejected: Int
    public let spam: Int
    
    public init(
        date: Date,
        count: Int,
        approved: Int,
        pending: Int,
        rejected: Int,
        spam: Int
    ) {
        self.date = date
        self.count = count
        self.approved = approved
        self.pending = pending
        self.rejected = rejected
        self.spam = spam
    }
}

public struct CommenterStatsDTO: Codable {
    public let authorName: String
    public let authorEmail: String
    public let commentCount: Int
    public let approvedCount: Int
    public let pendingCount: Int
    public let rejectedCount: Int
    public let spamCount: Int
    public let lastCommentAt: Date?
    
    public init(
        authorName: String,
        authorEmail: String,
        commentCount: Int,
        approvedCount: Int,
        pendingCount: Int,
        rejectedCount: Int,
        spamCount: Int,
        lastCommentAt: Date? = nil
    ) {
        self.authorName = authorName
        self.authorEmail = authorEmail
        self.commentCount = commentCount
        self.approvedCount = approvedCount
        self.pendingCount = pendingCount
        self.rejectedCount = rejectedCount
        self.spamCount = spamCount
        self.lastCommentAt = lastCommentAt
    }
}

public struct CommentSourceDTO: Codable {
    public let source: String
    public let count: Int
    public let percentage: Double
    
    public init(
        source: String,
        count: Int,
        percentage: Double
    ) {
        self.source = source
        self.count = count
        self.percentage = percentage
    }
}
