import Foundation

public struct CommentForm: Codable, Equatable {
    public let postId: UUID
    public let authorName: String
    public let authorEmail: String
    public let content: String
    public let parentId: UUID?
    public let website: String?
    public let notifyOnReply: Bool
    
    public init(
        postId: UUID,
        authorName: String,
        authorEmail: String,
        content: String,
        parentId: UUID? = nil,
        website: String? = nil,
        notifyOnReply: Bool = false
    ) {
        self.postId = postId
        self.authorName = authorName
        self.authorEmail = authorEmail
        self.content = content
        self.parentId = parentId
        self.website = website
        self.notifyOnReply = notifyOnReply
    }
    
    public var isValid: Bool {
        return !authorName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               !authorEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               isValidEmail(authorEmail)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    public var trimmedAuthorName: String {
        return authorName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var trimmedAuthorEmail: String {
        return authorEmail.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    public var trimmedContent: String {
        return content.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var wordCount: Int {
        return trimmedContent.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .count
    }
    
    public var characterCount: Int {
        return trimmedContent.count
    }
}

public struct CommentFormValidation: Codable {
    public let isValid: Bool
    public let errors: [CommentFormError]
    public let warnings: [CommentFormWarning]
    
    public init(
        isValid: Bool,
        errors: [CommentFormError] = [],
        warnings: [CommentFormWarning] = []
    ) {
        self.isValid = isValid
        self.errors = errors
        self.warnings = warnings
    }
}

public struct CommentFormError: Codable, Identifiable {
    public let id = UUID()
    public let field: String
    public let message: String
    public let code: CommentFormErrorCode
    
    public init(
        field: String,
        message: String,
        code: CommentFormErrorCode
    ) {
        self.field = field
        self.message = message
        self.code = code
    }
}

public struct CommentFormWarning: Codable, Identifiable {
    public let id = UUID()
    public let field: String
    public let message: String
    public let code: CommentFormWarningCode
    
    public init(
        field: String,
        message: String,
        code: CommentFormWarningCode
    ) {
        self.field = field
        self.message = message
        self.code = code
    }
}

public enum CommentFormErrorCode: String, Codable {
    case nameRequired = "name_required"
    case nameTooShort = "name_too_short"
    case nameTooLong = "name_too_long"
    case emailRequired = "email_required"
    case emailInvalid = "email_invalid"
    case contentRequired = "content_required"
    case contentTooShort = "content_too_short"
    case contentTooLong = "content_too_long"
    case postNotFound = "post_not_found"
    case parentCommentNotFound = "parent_comment_not_found"
    case duplicateComment = "duplicate_comment"
    case spamDetected = "spam_detected"
    
    public var displayName: String {
        switch self {
        case .nameRequired: return "이름은 필수입니다"
        case .nameTooShort: return "이름이 너무 짧습니다"
        case .nameTooLong: return "이름이 너무 깁니다"
        case .emailRequired: return "이메일은 필수입니다"
        case .emailInvalid: return "유효하지 않은 이메일입니다"
        case .contentRequired: return "댓글 내용은 필수입니다"
        case .contentTooShort: return "댓글 내용이 너무 짧습니다"
        case .contentTooLong: return "댓글 내용이 너무 깁니다"
        case .postNotFound: return "포스트를 찾을 수 없습니다"
        case .parentCommentNotFound: return "부모 댓글을 찾을 수 없습니다"
        case .duplicateComment: return "중복된 댓글입니다"
        case .spamDetected: return "스팸으로 감지되었습니다"
        }
    }
}

public enum CommentFormWarningCode: String, Codable {
    case nameSimilarToSpam = "name_similar_to_spam"
    case emailFromSpamDomain = "email_from_spam_domain"
    case contentContainsSpamKeywords = "content_contains_spam_keywords"
    case rapidPosting = "rapid_posting"
    case similarToPreviousComment = "similar_to_previous_comment"
    
    public var displayName: String {
        switch self {
        case .nameSimilarToSpam: return "이름이 스팸과 유사합니다"
        case .emailFromSpamDomain: return "스팸 도메인에서 온 이메일입니다"
        case .contentContainsSpamKeywords: return "내용에 스팸 키워드가 포함되어 있습니다"
        case .rapidPosting: return "너무 빠른 연속 댓글 작성입니다"
        case .similarToPreviousComment: return "이전 댓글과 유사합니다"
        }
    }
}
