import Foundation
import Domain

public class CommentService: CommentServiceProtocol, CommentModerationProtocol, CommentValidationProtocol {
    private let commentRepository: CommentRepositoryProtocol
    private let postRepository: PostRepositoryProtocol
    
    public init(
        commentRepository: CommentRepositoryProtocol,
        postRepository: PostRepositoryProtocol
    ) {
        self.commentRepository = commentRepository
        self.postRepository = postRepository
    }
    
    // MARK: - CommentServiceProtocol
    
    public func createComment(_ comment: Comment) async throws -> Comment {
        // Validate comment before creating
        let validation = try await validateComment(comment)
        guard validation.isValid else {
            throw CommentServiceError.validationFailed(validation.errors)
        }
        
        // Check for spam
        let spamCheck = try await checkSpam(comment)
        if spamCheck.isSpam {
            let spamComment = Comment(
                id: comment.id,
                postId: comment.postId,
                authorName: comment.authorName,
                authorEmail: comment.authorEmail,
                content: comment.content,
                status: .spam,
                createdAt: comment.createdAt,
                updatedAt: comment.updatedAt,
                parentId: comment.parentId,
                ipAddress: comment.ipAddress,
                userAgent: comment.userAgent
            )
            return try await commentRepository.createComment(spamComment)
        }
        
        return try await commentRepository.createComment(comment)
    }
    
    public func getComments(for postId: UUID) async throws -> [Comment] {
        return try await commentRepository.getComments(by: postId)
    }
    
    public func getApprovedComments(for postId: UUID) async throws -> [Comment] {
        return try await commentRepository.getApprovedComments(by: postId)
    }
    
    public func approveComment(id: UUID) async throws -> Bool {
        guard var comment = try await commentRepository.getComment(by: id) else {
            return false
        }
        
        let approvedComment = Comment(
            id: comment.id,
            postId: comment.postId,
            authorName: comment.authorName,
            authorEmail: comment.authorEmail,
            content: comment.content,
            status: .approved,
            createdAt: comment.createdAt,
            updatedAt: Date(),
            parentId: comment.parentId,
            ipAddress: comment.ipAddress,
            userAgent: comment.userAgent
        )
        
        _ = try await commentRepository.updateComment(approvedComment)
        return true
    }
    
    public func rejectComment(id: UUID) async throws -> Bool {
        guard var comment = try await commentRepository.getComment(by: id) else {
            return false
        }
        
        let rejectedComment = Comment(
            id: comment.id,
            postId: comment.postId,
            authorName: comment.authorName,
            authorEmail: comment.authorEmail,
            content: comment.content,
            status: .rejected,
            createdAt: comment.createdAt,
            updatedAt: Date(),
            parentId: comment.parentId,
            ipAddress: comment.ipAddress,
            userAgent: comment.userAgent
        )
        
        _ = try await commentRepository.updateComment(rejectedComment)
        return true
    }
    
    public func markAsSpam(id: UUID) async throws -> Bool {
        guard var comment = try await commentRepository.getComment(by: id) else {
            return false
        }
        
        let spamComment = Comment(
            id: comment.id,
            postId: comment.postId,
            authorName: comment.authorName,
            authorEmail: comment.authorEmail,
            content: comment.content,
            status: .spam,
            createdAt: comment.createdAt,
            updatedAt: Date(),
            parentId: comment.parentId,
            ipAddress: comment.ipAddress,
            userAgent: comment.userAgent
        )
        
        _ = try await commentRepository.updateComment(spamComment)
        return true
    }
    
    public func deleteComment(id: UUID) async throws -> Bool {
        return try await commentRepository.deleteComment(id: id)
    }
    
    public func getPendingComments() async throws -> [Comment] {
        return try await commentRepository.getComments(by: .pending)
    }
    
    public func getCommentStats() async throws -> CommentStats {
        let allComments = try await commentRepository.getAllComments()
        let approvedComments = allComments.filter { $0.status == .approved }
        let pendingComments = allComments.filter { $0.status == .pending }
        let rejectedComments = allComments.filter { $0.status == .rejected }
        let spamComments = allComments.filter { $0.status == .spam }
        
        let now = Date()
        let today = Calendar.current.startOfDay(for: now)
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: today)!
        
        let commentsToday = allComments.filter { $0.createdAt >= today }.count
        let commentsThisWeek = allComments.filter { $0.createdAt >= weekAgo }.count
        let commentsThisMonth = allComments.filter { $0.createdAt >= monthAgo }.count
        
        let allPosts = try await postRepository.getAllPosts()
        let averageCommentsPerPost = allPosts.isEmpty ? 0.0 : Double(allComments.count) / Double(allPosts.count)
        
        return CommentStats(
            totalComments: allComments.count,
            approvedComments: approvedComments.count,
            pendingComments: pendingComments.count,
            rejectedComments: rejectedComments.count,
            spamComments: spamComments.count,
            commentsToday: commentsToday,
            commentsThisWeek: commentsThisWeek,
            commentsThisMonth: commentsThisMonth,
            averageCommentsPerPost: averageCommentsPerPost
        )
    }
    
    // MARK: - CommentModerationProtocol
    
    public func moderateComment(_ comment: Comment) async throws -> CommentModerationResult {
        let spamCheck = try await checkSpam(comment)
        
        if spamCheck.isSpam {
            return CommentModerationResult(
                approved: false,
                reason: "스팸으로 감지됨",
                confidence: spamCheck.confidence,
                suggestions: spamCheck.reasons
            )
        }
        
        // Additional moderation logic can be added here
        return CommentModerationResult(
            approved: true,
            confidence: 1.0 - spamCheck.confidence
        )
    }
    
    public func bulkApprove(commentIds: [UUID]) async throws -> Int {
        var approvedCount = 0
        
        for id in commentIds {
            if try await approveComment(id: id) {
                approvedCount += 1
            }
        }
        
        return approvedCount
    }
    
    public func bulkReject(commentIds: [UUID]) async throws -> Int {
        var rejectedCount = 0
        
        for id in commentIds {
            if try await rejectComment(id: id) {
                rejectedCount += 1
            }
        }
        
        return rejectedCount
    }
    
    public func bulkMarkAsSpam(commentIds: [UUID]) async throws -> Int {
        var spamCount = 0
        
        for id in commentIds {
            if try await markAsSpam(id: id) {
                spamCount += 1
            }
        }
        
        return spamCount
    }
    
    public func getModerationQueue() async throws -> [Comment] {
        return try await getPendingComments()
    }
    
    // MARK: - CommentValidationProtocol
    
    public func validateComment(_ comment: Comment) async throws -> CommentValidationResult {
        var errors: [ValidationError] = []
        var warnings: [ValidationWarning] = []
        
        // Validate author name
        if comment.authorName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append(ValidationError(
                field: "authorName",
                message: "이름은 필수입니다",
                code: "name_required"
            ))
        } else if comment.authorName.count < 2 {
            errors.append(ValidationError(
                field: "authorName",
                message: "이름은 최소 2자 이상이어야 합니다",
                code: "name_too_short"
            ))
        } else if comment.authorName.count > 50 {
            errors.append(ValidationError(
                field: "authorName",
                message: "이름은 최대 50자까지 가능합니다",
                code: "name_too_long"
            ))
        }
        
        // Validate email
        if comment.authorEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append(ValidationError(
                field: "authorEmail",
                message: "이메일은 필수입니다",
                code: "email_required"
            ))
        } else if !isValidEmail(comment.authorEmail) {
            errors.append(ValidationError(
                field: "authorEmail",
                message: "유효하지 않은 이메일 형식입니다",
                code: "email_invalid"
            ))
        }
        
        // Validate content
        if comment.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append(ValidationError(
                field: "content",
                message: "댓글 내용은 필수입니다",
                code: "content_required"
            ))
        } else if comment.content.count < 5 {
            errors.append(ValidationError(
                field: "content",
                message: "댓글 내용은 최소 5자 이상이어야 합니다",
                code: "content_too_short"
            ))
        } else if comment.content.count > 1000 {
            errors.append(ValidationError(
                field: "content",
                message: "댓글 내용은 최대 1000자까지 가능합니다",
                code: "content_too_long"
            ))
        }
        
        // Validate post exists
        if try await postRepository.getPost(by: comment.postId) == nil {
            errors.append(ValidationError(
                field: "postId",
                message: "포스트를 찾을 수 없습니다",
                code: "post_not_found"
            ))
        }
        
        // Validate parent comment exists if specified
        if let parentId = comment.parentId {
            if try await commentRepository.getComment(by: parentId) == nil {
                errors.append(ValidationError(
                    field: "parentId",
                    message: "부모 댓글을 찾을 수 없습니다",
                    code: "parent_comment_not_found"
                ))
            }
        }
        
        return CommentValidationResult(
            isValid: errors.isEmpty,
            errors: errors,
            warnings: warnings
        )
    }
    
    public func checkSpam(_ comment: Comment) async throws -> SpamCheckResult {
        var score = 0
        var reasons: [String] = []
        
        // Check for common spam patterns
        let spamKeywords = ["viagra", "casino", "loan", "free money", "click here", "buy now"]
        let content = comment.content.lowercased()
        
        for keyword in spamKeywords {
            if content.contains(keyword) {
                score += 20
                reasons.append("스팸 키워드 감지: \(keyword)")
            }
        }
        
        // Check for excessive links
        let linkCount = content.components(separatedBy: "http").count - 1
        if linkCount > 2 {
            score += linkCount * 10
            reasons.append("과도한 링크 포함")
        }
        
        // Check for repetitive characters
        let repetitivePattern = try NSRegularExpression(pattern: "(.)\\1{4,}")
        if repetitivePattern.firstMatch(in: content, range: NSRange(content.startIndex..., in: content)) != nil {
            score += 15
            reasons.append("반복 문자 패턴 감지")
        }
        
        // Check for all caps
        if content == content.uppercased() && content.count > 10 {
            score += 10
            reasons.append("과도한 대문자 사용")
        }
        
        let isSpam = score >= 50
        let confidence = min(Double(score) / 100.0, 1.0)
        
        return SpamCheckResult(
            isSpam: isSpam,
            confidence: confidence,
            reasons: reasons,
            score: score
        )
    }
    
    public func checkDuplicate(_ comment: Comment) async throws -> Bool {
        let existingComments = try await commentRepository.getComments(by: comment.postId)
        
        return existingComments.contains { existing in
            existing.authorEmail == comment.authorEmail &&
            existing.content.trimmingCharacters(in: .whitespacesAndNewlines) == 
            comment.content.trimmingCharacters(in: .whitespacesAndNewlines) &&
            existing.createdAt.timeIntervalSince(comment.createdAt) < 300 // 5 minutes
        }
    }
    
    // MARK: - Private Methods
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

// MARK: - CommentServiceError

public enum CommentServiceError: Error {
    case validationFailed([ValidationError])
    case spamDetected(SpamCheckResult)
    case duplicateComment
    case postNotFound
    case parentCommentNotFound
    case commentNotFound
}
