import Foundation

public struct BlogEntity {
    public let config: BlogConfig
    public let totalPosts: Int
    public let totalComments: Int
    public let totalCategories: Int
    public let totalTags: Int
    public let recentPosts: [Post]
    public let popularPosts: [Post]
    public let categories: [Category]
    public let tags: [Tag]
    
    public init(
        config: BlogConfig,
        totalPosts: Int = 0,
        totalComments: Int = 0,
        totalCategories: Int = 0,
        totalTags: Int = 0,
        recentPosts: [Post] = [],
        popularPosts: [Post] = [],
        categories: [Category] = [],
        tags: [Tag] = []
    ) {
        self.config = config
        self.totalPosts = totalPosts
        self.totalComments = totalComments
        self.totalCategories = totalCategories
        self.totalTags = totalTags
        self.recentPosts = recentPosts
        self.popularPosts = popularPosts
        self.categories = categories
        self.tags = tags
    }
}

public struct BlogStats {
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
    
    public init(
        totalPosts: Int = 0,
        publishedPosts: Int = 0,
        draftPosts: Int = 0,
        totalComments: Int = 0,
        approvedComments: Int = 0,
        pendingComments: Int = 0,
        totalCategories: Int = 0,
        totalTags: Int = 0,
        totalViews: Int = 0,
        totalLikes: Int = 0
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
    }
}
