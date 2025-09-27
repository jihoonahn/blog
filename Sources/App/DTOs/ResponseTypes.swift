import Foundation

// MARK: - API Response Types

public struct APIResponse<T: Codable>: Codable {
    public let success: Bool
    public let data: T?
    public let message: String?
    public let error: APIError?
    public let timestamp: Date
    
    public init(
        success: Bool,
        data: T? = nil,
        message: String? = nil,
        error: APIError? = nil,
        timestamp: Date = Date()
    ) {
        self.success = success
        self.data = data
        self.message = message
        self.error = error
        self.timestamp = timestamp
    }
}

public struct APIError: Codable {
    public let code: String
    public let message: String
    public let details: [String: String]?
    
    public init(
        code: String,
        message: String,
        details: [String: String]? = nil
    ) {
        self.code = code
        self.message = message
        self.details = details
    }
}

// MARK: - Paginated Response

public struct PaginatedResponse<T: Codable>: Codable {
    public let data: [T]
    public let pagination: PaginationInfo
    public let success: Bool
    public let message: String?
    
    public init(
        data: [T],
        pagination: PaginationInfo,
        success: Bool = true,
        message: String? = nil
    ) {
        self.data = data
        self.pagination = pagination
        self.success = success
        self.message = message
    }
}

public struct PaginationInfo: Codable {
    public let page: Int
    public let limit: Int
    public let total: Int
    public let totalPages: Int
    public let hasNext: Bool
    public let hasPrevious: Bool
    public let nextPage: Int?
    public let previousPage: Int?
    
    public init(
        page: Int,
        limit: Int,
        total: Int,
        totalPages: Int,
        hasNext: Bool,
        hasPrevious: Bool,
        nextPage: Int?,
        previousPage: Int?
    ) {
        self.page = page
        self.limit = limit
        self.total = total
        self.totalPages = totalPages
        self.hasNext = hasNext
        self.hasPrevious = hasPrevious
        self.nextPage = nextPage
        self.previousPage = previousPage
    }
}

// MARK: - Basic DTOs

public struct PostDTO: Codable {
    public let id: String
    public let title: String
    public let content: String
    public let excerpt: String
    public let slug: String
    public let status: String
    public let publishedAt: Date?
    public let createdAt: Date
    public let updatedAt: Date
    public let authorId: String
    public let categoryId: String?
    public let tags: [TagDTO]
    public let featuredImage: String?
    public let viewCount: Int
    public let likeCount: Int
    public let commentCount: Int
    public let readingTime: Int
    public let wordCount: Int
    public let url: String
    
    public init(
        id: String,
        title: String,
        content: String,
        excerpt: String,
        slug: String,
        status: String,
        publishedAt: Date? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        authorId: String,
        categoryId: String? = nil,
        tags: [TagDTO] = [],
        featuredImage: String? = nil,
        viewCount: Int = 0,
        likeCount: Int = 0,
        commentCount: Int = 0,
        readingTime: Int = 0,
        wordCount: Int = 0,
        url: String
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.excerpt = excerpt
        self.slug = slug
        self.status = status
        self.publishedAt = publishedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.authorId = authorId
        self.categoryId = categoryId
        self.tags = tags
        self.featuredImage = featuredImage
        self.viewCount = viewCount
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.readingTime = readingTime
        self.wordCount = wordCount
        self.url = url
    }
}

public struct CategoryDTO: Codable {
    public let id: String
    public let name: String
    public let slug: String
    public let description: String?
    public let color: String?
    public let icon: String?
    public let parentId: String?
    public let createdAt: Date
    public let updatedAt: Date
    public let postCount: Int
    public let url: String
    
    public init(
        id: String,
        name: String,
        slug: String,
        description: String? = nil,
        color: String? = nil,
        icon: String? = nil,
        parentId: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        postCount: Int = 0,
        url: String
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.description = description
        self.color = color
        self.icon = icon
        self.parentId = parentId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.postCount = postCount
        self.url = url
    }
}

public struct TagDTO: Codable {
    public let id: String
    public let name: String
    public let slug: String
    public let color: String?
    public let description: String?
    public let createdAt: Date
    public let updatedAt: Date
    public let postCount: Int
    public let url: String
    
    public init(
        id: String,
        name: String,
        slug: String,
        color: String? = nil,
        description: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        postCount: Int = 0,
        url: String
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.color = color
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.postCount = postCount
        self.url = url
    }
}


// MARK: - Blog Response Types

public struct BlogListResponse: Codable {
    public let posts: [PostDTO]
    public let pagination: PaginationInfo
    public let categories: [CategoryDTO]
    public let tags: [TagDTO]
    
    public init(
        posts: [PostDTO],
        pagination: PaginationInfo,
        categories: [CategoryDTO],
        tags: [TagDTO]
    ) {
        self.posts = posts
        self.pagination = pagination
        self.categories = categories
        self.tags = tags
    }
}

public struct PostDetailResponse: Codable {
    public let post: PostDTO
    public let comments: [CommentDTO]
    public let relatedPosts: [PostDTO]
    public let category: CategoryDTO?
    public let tags: [TagDTO]
    
    public init(
        post: PostDTO,
        comments: [CommentDTO],
        relatedPosts: [PostDTO],
        category: CategoryDTO?,
        tags: [TagDTO]
    ) {
        self.post = post
        self.comments = comments
        self.relatedPosts = relatedPosts
        self.category = category
        self.tags = tags
    }
}

public struct SearchResponse: Codable {
    public let query: String
    public let results: [PostDTO]
    public let totalResults: Int
    public let pagination: PaginationInfo
    public let suggestions: [String]
    
    public init(
        query: String,
        results: [PostDTO],
        totalResults: Int,
        pagination: PaginationInfo,
        suggestions: [String]
    ) {
        self.query = query
        self.results = results
        self.totalResults = totalResults
        self.pagination = pagination
        self.suggestions = suggestions
    }
}

// MARK: - Comment Response Types

public struct CommentSubmitResponse: Codable {
    public let comment: CommentDTO?
    public let message: String
    public let requiresModeration: Bool
    public let estimatedApprovalTime: String?
    
    public init(
        comment: CommentDTO?,
        message: String,
        requiresModeration: Bool,
        estimatedApprovalTime: String? = nil
    ) {
        self.comment = comment
        self.message = message
        self.requiresModeration = requiresModeration
        self.estimatedApprovalTime = estimatedApprovalTime
    }
}

public struct CommentListResponse: Codable {
    public let comments: [CommentDTO]
    public let pagination: PaginationInfo
    public let stats: CommentStatsDTO
    
    public init(
        comments: [CommentDTO],
        pagination: PaginationInfo,
        stats: CommentStatsDTO
    ) {
        self.comments = comments
        self.pagination = pagination
        self.stats = stats
    }
}

// MARK: - Category Response Types

public struct CategoryListResponse: Codable {
    public let categories: [CategoryDTO]
    public let totalCount: Int
    public let topLevelCategories: [CategoryDTO]
    public let categoryTree: [CategoryTreeNode]
    
    public init(
        categories: [CategoryDTO],
        totalCount: Int,
        topLevelCategories: [CategoryDTO],
        categoryTree: [CategoryTreeNode]
    ) {
        self.categories = categories
        self.totalCount = totalCount
        self.topLevelCategories = topLevelCategories
        self.categoryTree = categoryTree
    }
}

public struct CategoryTreeNode: Codable {
    public let category: CategoryDTO
    public let children: [CategoryTreeNode]
    public let postCount: Int
    
    public init(
        category: CategoryDTO,
        children: [CategoryTreeNode],
        postCount: Int
    ) {
        self.category = category
        self.children = children
        self.postCount = postCount
    }
}

// MARK: - Tag Response Types

public struct TagListResponse: Codable {
    public let tags: [TagDTO]
    public let totalCount: Int
    public let popularTags: [TagDTO]
    public let tagCloud: [TagCloudItem]
    
    public init(
        tags: [TagDTO],
        totalCount: Int,
        popularTags: [TagDTO],
        tagCloud: [TagCloudItem]
    ) {
        self.tags = tags
        self.totalCount = totalCount
        self.popularTags = popularTags
        self.tagCloud = tagCloud
    }
}

public struct TagCloudItem: Codable {
    public let tag: TagDTO
    public let weight: Int
    public let fontSize: String
    
    public init(
        tag: TagDTO,
        weight: Int,
        fontSize: String
    ) {
        self.tag = tag
        self.weight = weight
        self.fontSize = fontSize
    }
}

// MARK: - Statistics Response Types

public struct BlogStatsResponse: Codable {
    public let stats: BlogStatsDTO
    public let recentActivity: [ActivityDTO]
    public let systemHealth: SystemHealthDTO
    public let lastUpdated: Date
    
    public init(
        stats: BlogStatsDTO,
        recentActivity: [ActivityDTO],
        systemHealth: SystemHealthDTO,
        lastUpdated: Date = Date()
    ) {
        self.stats = stats
        self.recentActivity = recentActivity
        self.systemHealth = systemHealth
        self.lastUpdated = lastUpdated
    }
}

public struct BlogStatsDTO: Codable {
    public let totalPosts: Int
    public let publishedPosts: Int
    public let draftPosts: Int
    public let totalComments: Int
    public let approvedComments: Int
    public let pendingComments: Int
    public let totalCategories: Int
    public let totalTags: Int
    public let totalViews: Int
    public let totalLikes: Int
    public let postsThisMonth: Int
    public let commentsThisMonth: Int
    public let averageCommentsPerPost: Double
    public let mostPopularPost: PostDTO?
    public let mostCommentedPost: PostDTO?
    
    public init(
        totalPosts: Int,
        publishedPosts: Int,
        draftPosts: Int,
        totalComments: Int,
        approvedComments: Int,
        pendingComments: Int,
        totalCategories: Int,
        totalTags: Int,
        totalViews: Int,
        totalLikes: Int,
        postsThisMonth: Int,
        commentsThisMonth: Int,
        averageCommentsPerPost: Double,
        mostPopularPost: PostDTO?,
        mostCommentedPost: PostDTO?
    ) {
        self.totalPosts = totalPosts
        self.publishedPosts = publishedPosts
        self.draftPosts = draftPosts
        self.totalComments = totalComments
        self.approvedComments = approvedComments
        self.pendingComments = pendingComments
        self.totalCategories = totalCategories
        self.totalTags = totalTags
        self.totalViews = totalViews
        self.totalLikes = totalLikes
        self.postsThisMonth = postsThisMonth
        self.commentsThisMonth = commentsThisMonth
        self.averageCommentsPerPost = averageCommentsPerPost
        self.mostPopularPost = mostPopularPost
        self.mostCommentedPost = mostCommentedPost
    }
}

public struct CommentStatsDTO: Codable {
    public let totalComments: Int
    public let approvedComments: Int
    public let pendingComments: Int
    public let rejectedComments: Int
    public let spamComments: Int
    public let commentsToday: Int
    public let commentsThisWeek: Int
    public let commentsThisMonth: Int
    public let averageCommentsPerPost: Double
    public let moderationQueueSize: Int
    public let averageModerationTime: String?
    
    public init(
        totalComments: Int,
        approvedComments: Int,
        pendingComments: Int,
        rejectedComments: Int,
        spamComments: Int,
        commentsToday: Int,
        commentsThisWeek: Int,
        commentsThisMonth: Int,
        averageCommentsPerPost: Double,
        moderationQueueSize: Int,
        averageModerationTime: String? = nil
    ) {
        self.totalComments = totalComments
        self.approvedComments = approvedComments
        self.pendingComments = pendingComments
        self.rejectedComments = rejectedComments
        self.spamComments = spamComments
        self.commentsToday = commentsToday
        self.commentsThisWeek = commentsThisWeek
        self.commentsThisMonth = commentsThisMonth
        self.averageCommentsPerPost = averageCommentsPerPost
        self.moderationQueueSize = moderationQueueSize
        self.averageModerationTime = averageModerationTime
    }
}

public struct ActivityDTO: Codable {
    public let id: String
    public let type: String
    public let description: String
    public let timestamp: Date
    public let user: String?
    public let metadata: [String: String]?
    
    public init(
        id: String,
        type: String,
        description: String,
        timestamp: Date,
        user: String? = nil,
        metadata: [String: String]? = nil
    ) {
        self.id = id
        self.type = type
        self.description = description
        self.timestamp = timestamp
        self.user = user
        self.metadata = metadata
    }
}

public struct SystemHealthDTO: Codable {
    public let status: String
    public let database: HealthCheckDTO
    public let storage: HealthCheckDTO
    public let memory: HealthCheckDTO
    public let uptime: String
    public let lastChecked: Date
    
    public init(
        status: String,
        database: HealthCheckDTO,
        storage: HealthCheckDTO,
        memory: HealthCheckDTO,
        uptime: String,
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

public struct HealthCheckDTO: Codable {
    public let status: String
    public let message: String
    public let responseTime: Double?
    public let lastChecked: Date
    
    public init(
        status: String,
        message: String,
        responseTime: Double? = nil,
        lastChecked: Date = Date()
    ) {
        self.status = status
        self.message = message
        self.responseTime = responseTime
        self.lastChecked = lastChecked
    }
}

// MARK: - Error Response Types

public struct ValidationErrorResponse: Codable {
    public let field: String
    public let message: String
    public let code: String
    public let value: String?
    
    public init(
        field: String,
        message: String,
        code: String,
        value: String? = nil
    ) {
        self.field = field
        self.message = message
        self.code = code
        self.value = value
    }
}

public struct BulkOperationResponse: Codable {
    public let totalItems: Int
    public let processedItems: Int
    public let successfulItems: Int
    public let failedItems: Int
    public let errors: [String]
    public let results: [BulkOperationResult]
    
    public init(
        totalItems: Int,
        processedItems: Int,
        successfulItems: Int,
        failedItems: Int,
        errors: [String],
        results: [BulkOperationResult]
    ) {
        self.totalItems = totalItems
        self.processedItems = processedItems
        self.successfulItems = successfulItems
        self.failedItems = failedItems
        self.errors = errors
        self.results = results
    }
}

public struct BulkOperationResult: Codable {
    public let id: String
    public let success: Bool
    public let message: String?
    public let error: String?
    
    public init(
        id: String,
        success: Bool,
        message: String? = nil,
        error: String? = nil
    ) {
        self.id = id
        self.success = success
        self.message = message
        self.error = error
    }
}
