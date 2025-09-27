import Foundation
import Domain

public class AdminRenderer {
    private let htmlRenderer: HTMLRenderer
    
    public init(htmlRenderer: HTMLRenderer) {
        self.htmlRenderer = htmlRenderer
    }
    
    // MARK: - Dashboard
    
    public func renderDashboard(stats: BlogStats) -> String {
        let content = """
        <div class="admin-dashboard">
            <h1>대시보드</h1>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <h3>총 포스트</h3>
                    <div class="stat-number">\(stats.totalPosts)</div>
                    <div class="stat-detail">발행: \(stats.publishedPosts), 초안: \(stats.draftPosts)</div>
                </div>
                
                <div class="stat-card">
                    <h3>댓글</h3>
                    <div class="stat-number">\(stats.totalComments)</div>
                    <div class="stat-detail">승인: \(stats.approvedComments), 대기: \(stats.pendingComments)</div>
                </div>
                
                <div class="stat-card">
                    <h3>카테고리</h3>
                    <div class="stat-number">\(stats.totalCategories)</div>
                </div>
                
                <div class="stat-card">
                    <h3>태그</h3>
                    <div class="stat-number">\(stats.totalTags)</div>
                </div>
                
                <div class="stat-card">
                    <h3>조회수</h3>
                    <div class="stat-number">\(stats.totalViews)</div>
                </div>
                
                <div class="stat-card">
                    <h3>좋아요</h3>
                    <div class="stat-number">\(stats.totalLikes)</div>
                </div>
            </div>
            
            <div class="dashboard-actions">
                <a href="/admin/posts/new" class="btn btn-primary">새 포스트 작성</a>
                <a href="/admin/comments" class="btn btn-secondary">댓글 관리</a>
            </div>
        </div>
        """
        
        return htmlRenderer.renderAdminLayout(title: "대시보드", content: content)
    }
    
    // MARK: - Posts Management
    
    public func renderPostList(posts: [Post], pagination: Pagination? = nil) -> String {
        var content = """
        <div class="admin-posts">
            <div class="admin-header">
                <h1>포스트 관리</h1>
                <a href="/admin/posts/new" class="btn btn-primary">새 포스트</a>
            </div>
            
            <div class="posts-table">
                <table>
                    <thead>
                        <tr>
                            <th>제목</th>
                            <th>상태</th>
                            <th>작성일</th>
                            <th>조회수</th>
                            <th>작업</th>
                        </tr>
                    </thead>
                    <tbody>
        """
        
        for post in posts {
            content += renderPostRow(post)
        }
        
        content += """
                    </tbody>
                </table>
            </div>
        """
        
        if let pagination = pagination {
            content += htmlRenderer.renderPagination(pagination)
        }
        
        content += "</div>"
        
        return htmlRenderer.renderAdminLayout(title: "포스트 관리", content: content)
    }
    
    private func renderPostRow(_ post: Post) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let statusClass = post.status == .published ? "status-published" : "status-draft"
        
        return """
        <tr>
            <td>
                <a href="/admin/posts/\(post.id)">\(post.title)</a>
            </td>
            <td>
                <span class="status \(statusClass)">\(post.status.displayName)</span>
            </td>
            <td>\(dateFormatter.string(from: post.createdAt))</td>
            <td>\(post.viewCount)</td>
            <td>
                <a href="/admin/posts/\(post.id)/edit" class="btn btn-sm">수정</a>
                <button class="btn btn-sm btn-danger" onclick="deletePost('\(post.id)')">삭제</button>
            </td>
        </tr>
        """
    }
    
    public func renderPostForm(post: Post? = nil) -> String {
        let isEdit = post != nil
        let title = isEdit ? "포스트 수정" : "새 포스트 작성"
        let action = isEdit ? "/admin/posts/\(post!.id)" : "/admin/posts"
        let method = isEdit ? "PUT" : "POST"
        
        let content = """
        <div class="admin-post-form">
            <h1>\(title)</h1>
            
            <form id="post-form" action="\(action)" method="\(method)">
                <div class="form-group">
                    <label for="title">제목 *</label>
                    <input type="text" id="title" name="title" value="\(post?.title ?? "")" required>
                </div>
                
                <div class="form-group">
                    <label for="slug">슬러그 *</label>
                    <input type="text" id="slug" name="slug" value="\(post?.slug ?? "")" required>
                </div>
                
                <div class="form-group">
                    <label for="excerpt">요약</label>
                    <textarea id="excerpt" name="excerpt" rows="3">\(post?.excerpt ?? "")</textarea>
                </div>
                
                <div class="form-group">
                    <label for="content">내용 *</label>
                    <textarea id="content" name="content" rows="20" required>\(post?.content ?? "")</textarea>
                </div>
                
                <div class="form-group">
                    <label for="status">상태</label>
                    <select id="status" name="status">
                        <option value="draft" \(post?.status == .draft ? "selected" : "")>초안</option>
                        <option value="published" \(post?.status == .published ? "selected" : "")>발행</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="featured-image">대표 이미지</label>
                    <input type="url" id="featured-image" name="featuredImage" value="\(post?.featuredImage ?? "")">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">\(isEdit ? "수정" : "작성")</button>
                    <a href="/admin/posts" class="btn btn-secondary">취소</a>
                </div>
            </form>
        </div>
        """
        
        return htmlRenderer.renderAdminLayout(title: title, content: content)
    }
    
    // MARK: - Comments Management
    
    public func renderCommentList(comments: [Comment], pagination: Pagination? = nil) -> String {
        var content = """
        <div class="admin-comments">
            <div class="admin-header">
                <h1>댓글 관리</h1>
                <div class="comment-filters">
                    <select id="status-filter">
                        <option value="">모든 댓글</option>
                        <option value="pending">대기중</option>
                        <option value="approved">승인됨</option>
                        <option value="rejected">거부됨</option>
                        <option value="spam">스팸</option>
                    </select>
                </div>
            </div>
            
            <div class="comments-table">
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="select-all"></th>
                            <th>작성자</th>
                            <th>내용</th>
                            <th>상태</th>
                            <th>작성일</th>
                            <th>작업</th>
                        </tr>
                    </thead>
                    <tbody>
        """
        
        for comment in comments {
            content += renderCommentRow(comment)
        }
        
        content += """
                    </tbody>
                </table>
            </div>
            
            <div class="bulk-actions">
                <button class="btn btn-primary" onclick="bulkApprove()">일괄 승인</button>
                <button class="btn btn-warning" onclick="bulkReject()">일괄 거부</button>
                <button class="btn btn-danger" onclick="bulkMarkSpam()">스팸 처리</button>
            </div>
        """
        
        if let pagination = pagination {
            content += htmlRenderer.renderPagination(pagination)
        }
        
        content += "</div>"
        
        return htmlRenderer.renderAdminLayout(title: "댓글 관리", content: content)
    }
    
    private func renderCommentRow(_ comment: Comment) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let statusClass = "status-\(comment.status.rawValue)"
        let contentPreview = String(comment.content.prefix(100))
        
        return """
        <tr>
            <td><input type="checkbox" class="comment-checkbox" value="\(comment.id)"></td>
            <td>
                <div class="comment-author">
                    <strong>\(comment.authorName)</strong>
                    <br><small>\(comment.authorEmail)</small>
                </div>
            </td>
            <td>
                <div class="comment-content-preview">\(contentPreview)</div>
            </td>
            <td>
                <span class="status \(statusClass)">\(comment.status.displayName)</span>
            </td>
            <td>\(dateFormatter.string(from: comment.createdAt))</td>
            <td>
                <button class="btn btn-sm btn-success" onclick="approveComment('\(comment.id)')">승인</button>
                <button class="btn btn-sm btn-warning" onclick="rejectComment('\(comment.id)')">거부</button>
                <button class="btn btn-sm btn-danger" onclick="markSpam('\(comment.id)')">스팸</button>
                <button class="btn btn-sm btn-danger" onclick="deleteComment('\(comment.id)')">삭제</button>
            </td>
        </tr>
        """
    }
    
    // MARK: - Categories Management
    
    public func renderCategoryList(categories: [Domain.Category]) -> String {
        var content = """
        <div class="admin-categories">
            <div class="admin-header">
                <h1>카테고리 관리</h1>
                <button class="btn btn-primary" onclick="showCategoryForm()">새 카테고리</button>
            </div>
            
            <div class="categories-table">
                <table>
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>슬러그</th>
                            <th>포스트 수</th>
                            <th>작성일</th>
                            <th>작업</th>
                        </tr>
                    </thead>
                    <tbody>
        """
        
        for category in categories {
            content += renderCategoryRow(category)
        }
        
        content += """
                    </tbody>
                </table>
            </div>
        </div>
        """
        
        return htmlRenderer.renderAdminLayout(title: "카테고리 관리", content: content)
    }
    
    private func renderCategoryRow(_ category: Domain.Category) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return """
        <tr>
            <td>\(category.name)</td>
            <td>\(category.slug)</td>
            <td>\(category.postCount)</td>
            <td>\(dateFormatter.string(from: category.createdAt))</td>
            <td>
                <button class="btn btn-sm" onclick="editCategory('\(category.id)')">수정</button>
                <button class="btn btn-sm btn-danger" onclick="deleteCategory('\(category.id)')">삭제</button>
            </td>
        </tr>
        """
    }
    
    // MARK: - Tags Management
    
    public func renderTagList(tags: [Tag]) -> String {
        var content = """
        <div class="admin-tags">
            <div class="admin-header">
                <h1>태그 관리</h1>
                <button class="btn btn-primary" onclick="showTagForm()">새 태그</button>
            </div>
            
            <div class="tags-table">
                <table>
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>슬러그</th>
                            <th>포스트 수</th>
                            <th>작성일</th>
                            <th>작업</th>
                        </tr>
                    </thead>
                    <tbody>
        """
        
        for tag in tags {
            content += renderTagRow(tag)
        }
        
        content += """
                    </tbody>
                </table>
            </div>
        </div>
        """
        
        return htmlRenderer.renderAdminLayout(title: "태그 관리", content: content)
    }
    
    private func renderTagRow(_ tag: Tag) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return """
        <tr>
            <td>\(tag.name)</td>
            <td>\(tag.slug)</td>
            <td>\(tag.postCount)</td>
            <td>\(dateFormatter.string(from: tag.createdAt))</td>
            <td>
                <button class="btn btn-sm" onclick="editTag('\(tag.id)')">수정</button>
                <button class="btn btn-sm btn-danger" onclick="deleteTag('\(tag.id)')">삭제</button>
            </td>
        </tr>
        """
    }
    
    // MARK: - Settings
    
    public func renderSettings(config: BlogConfig) -> String {
        let content = """
        <div class="admin-settings">
            <h1>블로그 설정</h1>
            
            <form id="settings-form" action="/admin/settings" method="POST">
                <div class="form-section">
                    <h3>기본 정보</h3>
                    
                    <div class="form-group">
                        <label for="site-name">사이트 이름 *</label>
                        <input type="text" id="site-name" name="siteName" value="\(config.siteName)" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="site-description">사이트 설명</label>
                        <textarea id="site-description" name="siteDescription" rows="3">\(config.siteDescription)</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="site-url">사이트 URL</label>
                        <input type="url" id="site-url" name="siteUrl" value="\(config.siteUrl)">
                    </div>
                    
                    <div class="form-group">
                        <label for="admin-email">관리자 이메일</label>
                        <input type="email" id="admin-email" name="adminEmail" value="\(config.adminEmail)">
                    </div>
                </div>
                
                <div class="form-section">
                    <h3>포스트 설정</h3>
                    
                    <div class="form-group">
                        <label for="posts-per-page">페이지당 포스트 수</label>
                        <input type="number" id="posts-per-page" name="postsPerPage" value="\(config.postsPerPage)" min="1" max="50">
                    </div>
                    
                    <div class="form-group">
                        <label>
                            <input type="checkbox" name="allowComments" \(config.allowComments ? "checked" : "")>
                            댓글 허용
                        </label>
                    </div>
                    
                    <div class="form-group">
                        <label>
                            <input type="checkbox" name="moderateComments" \(config.moderateComments ? "checked" : "")>
                            댓글 검토
                        </label>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">설정 저장</button>
                </div>
            </form>
        </div>
        """
        
        return htmlRenderer.renderAdminLayout(title: "블로그 설정", content: content)
    }
    
    // MARK: - Login
    
    public func renderLogin() -> String {
        let content = """
        <div class="admin-login">
            <div class="login-container">
                <h1>관리자 로그인</h1>
                
                <form id="login-form" action="/admin/login" method="POST">
                    <div class="form-group">
                        <label for="username">사용자명</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">비밀번호</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    
                    <div class="form-group">
                        <label>
                            <input type="checkbox" name="rememberMe">
                            로그인 상태 유지
                        </label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-full">로그인</button>
                </form>
            </div>
        </div>
        """
        
        return htmlRenderer.renderLayout(title: "관리자 로그인", content: content)
    }
}
