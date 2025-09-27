import Foundation

// MARK: - Comment Service Protocol
public protocol CommentServiceProtocol {
    func createComment(_ comment: Comment) async throws -> Comment
    func getComments(for postId: UUID) async throws -> [Comment]
    func getApprovedComments(for postId: UUID) async throws -> [Comment]
    func approveComment(id: UUID) async throws -> Bool
    func rejectComment(id: UUID) async throws -> Bool
    func markAsSpam(id: UUID) async throws -> Bool
    func deleteComment(id: UUID) async throws -> Bool
    func getPendingComments() async throws -> [Comment]
    func getCommentStats() async throws -> CommentStats
}

// MARK: - Comment Moderation Protocol
public protocol CommentModerationProtocol {
    func moderateComment(_ comment: Comment) async throws -> CommentModerationResult
    func bulkApprove(commentIds: [UUID]) async throws -> Int
    func bulkReject(commentIds: [UUID]) async throws -> Int
    func bulkMarkAsSpam(commentIds: [UUID]) async throws -> Int
    func getModerationQueue() async throws -> [Comment]
}

// MARK: - Comment Validation Protocol
public protocol CommentValidationProtocol {
    func validateComment(_ comment: Comment) async throws -> CommentValidationResult
    func checkSpam(_ comment: Comment) async throws -> SpamCheckResult
    func checkDuplicate(_ comment: Comment) async throws -> Bool
}

// MARK: - Comment Stats
public struct CommentStats: Codable {
    public let totalComments: Int
    public let approvedComments: Int
    public let pendingComments: Int
    public let rejectedComments: Int
    public let spamComments: Int
    public let commentsToday: Int
    public let commentsThisWeek: Int
    public let commentsThisMonth: Int
    public let averageCommentsPerPost: Double
    
    public init(
        totalComments: Int = 0,
        approvedComments: Int = 0,
        pendingComments: Int = 0,
        rejectedComments: Int = 0,
        spamComments: Int = 0,
        commentsToday: Int = 0,
        commentsThisWeek: Int = 0,
        commentsThisMonth: Int = 0,
        averageCommentsPerPost: Double = 0.0
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
    }
}

// MARK: - Comment Moderation Result
public struct CommentModerationResult: Codable {
    public let approved: Bool
    public let reason: String?
    public let confidence: Double
    public let suggestions: [String]
    
    public init(
        approved: Bool,
        reason: String? = nil,
        confidence: Double = 0.0,
        suggestions: [String] = []
    ) {
        self.approved = approved
        self.reason = reason
        self.confidence = confidence
        self.suggestions = suggestions
    }
}

// MARK: - Comment Validation Result
public struct CommentValidationResult: Codable {
    public let isValid: Bool
    public let errors: [ValidationError]
    public let warnings: [ValidationWarning]
    
    public init(
        isValid: Bool,
        errors: [ValidationError] = [],
        warnings: [ValidationWarning] = []
    ) {
        self.isValid = isValid
        self.errors = errors
        self.warnings = warnings
    }
}

// MARK: - Spam Check Result
public struct SpamCheckResult: Codable, Sendable {
    public let isSpam: Bool
    public let confidence: Double
    public let reasons: [String]
    public let score: Int
    
    public init(
        isSpam: Bool,
        confidence: Double = 0.0,
        reasons: [String] = [],
        score: Int = 0
    ) {
        self.isSpam = isSpam
        self.confidence = confidence
        self.reasons = reasons
        self.score = score
    }
}

// MARK: - Validation Error
public struct ValidationError: Codable, Sendable {
    public let field: String
    public let message: String
    public let code: String
    
    public init(
        field: String,
        message: String,
        code: String
    ) {
        self.field = field
        self.message = message
        self.code = code
    }
}

// MARK: - Validation Warning
public struct ValidationWarning: Codable {
    public let field: String
    public let message: String
    public let code: String
    
    public init(
        field: String,
        message: String,
        code: String
    ) {
        self.field = field
        self.message = message
        self.code = code
    }
}
