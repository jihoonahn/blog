import Foundation
import Domain

public class CommentRenderer {
    private let htmlRenderer: HTMLRenderer
    
    public init(htmlRenderer: HTMLRenderer) {
        self.htmlRenderer = htmlRenderer
    }
    
    // MARK: - Comment Components
    
    public func renderCommentSection(postId: UUID, comments: [Comment], allowComments: Bool = true) -> String {
        var content = "<div class=\"comment-section\" data-post-id=\"\(postId)\">"
        content += "<h3>댓글 (\(comments.count))</h3>"
        
        if allowComments {
            content += renderCommentForm(postId: postId)
        }
        
        content += "<div class=\"comments-list\">"
        for comment in comments {
            content += renderCommentItem(comment)
        }
        content += "</div>"
        
        content += "</div>"
        return content
    }
    
    public func renderCommentItem(_ comment: Comment, showActions: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        
        var content = """
        <div class="comment-item" data-comment-id="\(comment.id)">
            <div class="comment-header">
                <div class="comment-author">
                    <strong>\(comment.authorName)</strong>
                </div>
                <div class="comment-meta">
                    <time datetime="\(comment.createdAt.ISO8601Format())">\(dateFormatter.string(from: comment.createdAt))</time>
                    <span class="comment-status status-\(comment.status.rawValue)">\(comment.status.displayName)</span>
                </div>
            </div>
            
            <div class="comment-content">
                \(comment.content)
            </div>
        """
        
        if showActions {
            content += renderCommentActions(comment)
        }
        
        content += "</div>"
        return content
    }
    
    private func renderCommentActions(_ comment: Comment) -> String {
        var actions = "<div class=\"comment-actions\">"
        
        switch comment.status {
        case .pending:
            actions += """
            <button class="btn btn-sm btn-success" onclick="approveComment('\(comment.id)')">승인</button>
            <button class="btn btn-sm btn-warning" onclick="rejectComment('\(comment.id)')">거부</button>
            <button class="btn btn-sm btn-danger" onclick="markSpam('\(comment.id)')">스팸</button>
            """
        case .approved:
            actions += """
            <button class="btn btn-sm btn-warning" onclick="rejectComment('\(comment.id)')">거부</button>
            <button class="btn btn-sm btn-danger" onclick="markSpam('\(comment.id)')">스팸</button>
            """
        case .rejected:
            actions += """
            <button class="btn btn-sm btn-success" onclick="approveComment('\(comment.id)')">승인</button>
            <button class="btn btn-sm btn-danger" onclick="markSpam('\(comment.id)')">스팸</button>
            """
        case .spam:
            actions += """
            <button class="btn btn-sm btn-success" onclick="approveComment('\(comment.id)')">승인</button>
            <button class="btn btn-sm btn-warning" onclick="rejectComment('\(comment.id)')">거부</button>
            """
        }
        
        actions += """
        <button class="btn btn-sm btn-danger" onclick="deleteComment('\(comment.id)')">삭제</button>
        </div>
        """
        
        return actions
    }
    
    public func renderCommentForm(postId: UUID, parentId: UUID? = nil) -> String {
        let isReply = parentId != nil
        let formTitle = isReply ? "답글 작성" : "댓글 작성"
        
        return """
        <div class="comment-form-container" data-parent-id="\(parentId?.uuidString ?? "")">
            <h4>\(formTitle)</h4>
            <form class="comment-form" id="comment-form-\(postId)" data-post-id="\(postId)">
                <div class="form-row">
                    <div class="form-group">
                        <label for="author-name-\(postId)">이름 *</label>
                        <input type="text" id="author-name-\(postId)" name="authorName" required maxlength="50">
                    </div>
                    <div class="form-group">
                        <label for="author-email-\(postId)">이메일 *</label>
                        <input type="email" id="author-email-\(postId)" name="authorEmail" required maxlength="100">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="comment-content-\(postId)">댓글 *</label>
                    <textarea id="comment-content-\(postId)" name="content" rows="4" required maxlength="1000" placeholder="댓글을 입력하세요..."></textarea>
                    <div class="char-count">
                        <span class="current">0</span> / <span class="max">1000</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>
                        <input type="checkbox" name="notifyOnReply">
                        답글 알림 받기
                    </label>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">\(formTitle)</button>
                    \(isReply ? "<button type=\\\"button\\\" class=\\\"btn btn-secondary\\\" onclick=\\\"cancelReply()\\\">취소</button>" : "")
                </div>
            </form>
        </div>
        """
    }
    
    // MARK: - Comment List Views
    
    public func renderCommentList(comments: [Comment], showActions: Bool = false) -> String {
        var content = "<div class=\"comments-list\">"
        
        if comments.isEmpty {
            content += "<p class=\"no-comments\">아직 댓글이 없습니다.</p>"
        } else {
            for comment in comments {
                content += renderCommentItem(comment, showActions: showActions)
            }
        }
        
        content += "</div>"
        return content
    }
    
    public func renderCommentTree(comments: [Comment], showActions: Bool = false) -> String {
        // Group comments by parent
        let rootComments = comments.filter { $0.parentId == nil }
        let replies = Dictionary(grouping: comments.filter { $0.parentId != nil }) { $0.parentId! }
        
        var content = "<div class=\"comment-tree\">"
        
        for comment in rootComments {
            content += renderCommentWithReplies(comment, replies: replies[comment.id] ?? [], showActions: showActions)
        }
        
        content += "</div>"
        return content
    }
    
    private func renderCommentWithReplies(_ comment: Comment, replies: [Comment], showActions: Bool) -> String {
        var content = renderCommentItem(comment, showActions: showActions)
        
        if !replies.isEmpty {
            content += "<div class=\"comment-replies\">"
            for reply in replies {
                content += renderCommentItem(reply, showActions: showActions)
            }
            content += "</div>"
        }
        
        return content
    }
    
    // MARK: - Comment Moderation
    
    public func renderModerationQueue(comments: [Comment]) -> String {
        var content = """
        <div class="moderation-queue">
            <div class="queue-header">
                <h2>댓글 검토 대기열</h2>
                <div class="queue-stats">
                    <span class="pending-count">대기중: \(comments.filter { $0.status == .pending }.count)</span>
                </div>
            </div>
            
            <div class="bulk-actions">
                <button class="btn btn-primary" onclick="bulkApprove()">선택 항목 승인</button>
                <button class="btn btn-warning" onclick="bulkReject()">선택 항목 거부</button>
                <button class="btn btn-danger" onclick="bulkMarkSpam()">선택 항목 스팸 처리</button>
            </div>
            
            <div class="moderation-list">
        """
        
        for comment in comments {
            content += renderModerationItem(comment)
        }
        
        content += """
            </div>
        </div>
        """
        
        return content
    }
    
    private func renderModerationItem(_ comment: Comment) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return """
        <div class="moderation-item" data-comment-id="\(comment.id)">
            <div class="moderation-header">
                <input type="checkbox" class="moderation-checkbox" value="\(comment.id)">
                <div class="comment-info">
                    <strong>\(comment.authorName)</strong> - \(comment.authorEmail)
                    <span class="comment-date">\(dateFormatter.string(from: comment.createdAt))</span>
                </div>
            </div>
            
            <div class="comment-preview">
                \(String(comment.content.prefix(200)))\(comment.content.count > 200 ? "..." : "")
            </div>
            
            <div class="moderation-actions">
                <button class="btn btn-sm btn-success" onclick="approveComment('\(comment.id)')">승인</button>
                <button class="btn btn-sm btn-warning" onclick="rejectComment('\(comment.id)')">거부</button>
                <button class="btn btn-sm btn-danger" onclick="markSpam('\(comment.id)')">스팸</button>
                <button class="btn btn-sm btn-danger" onclick="deleteComment('\(comment.id)')">삭제</button>
            </div>
        </div>
        """
    }
    
    // MARK: - Comment Statistics
    
    public func renderCommentStats(_ stats: CommentStats) -> String {
        return """
        <div class="comment-stats">
            <h3>댓글 통계</h3>
            
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">\(stats.totalComments)</div>
                    <div class="stat-label">총 댓글</div>
                </div>
                
                <div class="stat-item">
                    <div class="stat-number">\(stats.approvedComments)</div>
                    <div class="stat-label">승인됨</div>
                </div>
                
                <div class="stat-item">
                    <div class="stat-number">\(stats.pendingComments)</div>
                    <div class="stat-label">대기중</div>
                </div>
                
                <div class="stat-item">
                    <div class="stat-number">\(stats.rejectedComments)</div>
                    <div class="stat-label">거부됨</div>
                </div>
                
                <div class="stat-item">
                    <div class="stat-number">\(stats.spamComments)</div>
                    <div class="stat-label">스팸</div>
                </div>
                
                <div class="stat-item">
                    <div class="stat-number">\(stats.commentsToday)</div>
                    <div class="stat-label">오늘</div>
                </div>
                
                <div class="stat-item">
                    <div class="stat-number">\(stats.commentsThisWeek)</div>
                    <div class="stat-label">이번 주</div>
                </div>
                
                <div class="stat-item">
                    <div class="stat-number">\(String(format: "%.1f", stats.averageCommentsPerPost))</div>
                    <div class="stat-label">포스트당 평균</div>
                </div>
            </div>
        </div>
        """
    }
    
    // MARK: - Comment Validation Messages
    
    public func renderValidationErrors(_ errors: [ValidationError]) -> String {
        if errors.isEmpty {
            return ""
        }
        
        var content = "<div class=\"validation-errors\">"
        content += "<h4>입력 오류:</h4>"
        content += "<ul>"
        
        for error in errors {
            content += "<li>\(error.message)</li>"
        }
        
        content += "</ul></div>"
        return content
    }
    
    public func renderValidationWarnings(_ warnings: [ValidationWarning]) -> String {
        if warnings.isEmpty {
            return ""
        }
        
        var content = "<div class=\"validation-warnings\">"
        content += "<h4>주의사항:</h4>"
        content += "<ul>"
        
        for warning in warnings {
            content += "<li>\(warning.message)</li>"
        }
        
        content += "</ul></div>"
        return content
    }
    
    // MARK: - Comment Success Messages
    
    public func renderCommentSuccess() -> String {
        return """
        <div class="comment-success">
            <p>댓글이 성공적으로 작성되었습니다. 검토 후 게시됩니다.</p>
        </div>
        """
    }
    
    public func renderCommentPending() -> String {
        return """
        <div class="comment-pending">
            <p>댓글이 제출되었습니다. 관리자 승인 후 게시됩니다.</p>
        </div>
        """
    }
}
