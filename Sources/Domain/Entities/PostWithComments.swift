import Foundation

public struct PostWithComments {
    public let post: Post
    public let comments: [Comment]
    public let approvedComments: [Comment]
    public let pendingComments: [Comment]
    public let commentCount: Int
    public let approvedCommentCount: Int
    public let pendingCommentCount: Int
    
    public init(
        post: Post,
        comments: [Comment] = []
    ) {
        self.post = post
        self.comments = comments
        self.approvedComments = comments.filter { $0.status == .approved }
        self.pendingComments = comments.filter { $0.status == .pending }
        self.commentCount = comments.count
        self.approvedCommentCount = self.approvedComments.count
        self.pendingCommentCount = self.pendingComments.count
    }
}

public struct PostSummary {
    public let post: Post
    public let commentCount: Int
    public let category: Category?
    public let isPopular: Bool
    public let readingTime: Int // 분 단위
    
    public init(
        post: Post,
        commentCount: Int = 0,
        category: Category? = nil,
        isPopular: Bool = false,
        readingTime: Int = 0
    ) {
        self.post = post
        self.commentCount = commentCount
        self.category = category
        self.isPopular = isPopular
        self.readingTime = readingTime
    }
}

public struct PostDetail {
    public let post: Post
    public let comments: [Comment]
    public let category: Category?
    public let relatedPosts: [Post]
    public let readingTime: Int
    public let wordCount: Int
    
    public init(
        post: Post,
        comments: [Comment] = [],
        category: Category? = nil,
        relatedPosts: [Post] = [],
        readingTime: Int = 0,
        wordCount: Int = 0
    ) {
        self.post = post
        self.comments = comments
        self.category = category
        self.relatedPosts = relatedPosts
        self.readingTime = readingTime
        self.wordCount = wordCount
    }
}
