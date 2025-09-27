import Foundation
import Domain

public class HTMLRenderer {
    private let config: BlogConfig
    
    public init(config: BlogConfig) {
        self.config = config
    }
    
    // MARK: - Layout Templates
    
    public func renderLayout(title: String, content: String, additionalHead: String = "") -> String {
        return """
        <!DOCTYPE html>
        <html lang="\(config.language)">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>\(title) - \(config.siteName)</title>
            <meta name="description" content="\(config.siteDescription)">
            <link rel="stylesheet" href="/style.css">
            <script type="module" src="/index.js"></script>
            \(additionalHead)
        </head>
        <body>
            <header class="header">
                \(renderHeader())
            </header>
            
            <main class="main">
                \(content)
            </main>
            
            <footer class="footer">
                \(renderFooter())
            </footer>
        </body>
        </html>
        """
    }
    
    public func renderAdminLayout(title: String, content: String, additionalHead: String = "") -> String {
        return """
        <!DOCTYPE html>
        <html lang="\(config.language)">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>\(title) - 관리자</title>
            <link rel="stylesheet" href="/style.css">
            <script type="module" src="/index.js"></script>
            \(additionalHead)
        </head>
        <body class="admin-body">
            <nav class="admin-nav">
                \(renderAdminNav())
            </nav>
            
            <main class="admin-main">
                \(content)
            </main>
        </body>
        </html>
        """
    }
    
    // MARK: - Header & Footer
    
    private func renderHeader() -> String {
        return """
        <div class="container">
            <div class="header-content">
                <h1 class="site-title">
                    <a href="/">\(config.siteName)</a>
                </h1>
                <p class="site-description">\(config.siteDescription)</p>
                <nav class="main-nav">
                    <a href="/">홈</a>
                    <a href="/categories">카테고리</a>
                    <a href="/tags">태그</a>
                    <a href="/about">소개</a>
                </nav>
            </div>
        </div>
        """
    }
    
    private func renderFooter() -> String {
        return """
        <div class="container">
            <div class="footer-content">
                <p>&copy; \(Calendar.current.component(.year, from: Date())) \(config.siteName). All rights reserved.</p>
                <div class="social-links">
                    \(renderSocialLinks())
                </div>
            </div>
        </div>
        """
    }
    
    private func renderSocialLinks() -> String {
        var links = ""
        for (platform, url) in config.socialLinks {
            links += "<a href=\"\(url)\" target=\"_blank\" rel=\"noopener\">\(platform)</a>"
        }
        return links
    }
    
    private func renderAdminNav() -> String {
        return """
        <div class="admin-nav-content">
            <h2>관리자 패널</h2>
            <ul class="admin-nav-menu">
                <li><a href="/admin">대시보드</a></li>
                <li><a href="/admin/posts">포스트</a></li>
                <li><a href="/admin/comments">댓글</a></li>
                <li><a href="/admin/categories">카테고리</a></li>
                <li><a href="/admin/tags">태그</a></li>
                <li><a href="/admin/settings">설정</a></li>
                <li><a href="/admin/logout">로그아웃</a></li>
            </ul>
        </div>
        """
    }
    
    // MARK: - Post Rendering
    
    public func renderPostList(posts: [Post], pagination: Pagination? = nil) -> String {
        var content = "<div class=\"post-list\">"
        
        for post in posts {
            content += renderPostCard(post)
        }
        
        content += "</div>"
        
        if let pagination = pagination {
            content += renderPagination(pagination)
        }
        
        return content
    }
    
    public func renderPostCard(_ post: Post) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = config.dateFormat
        
        return """
        <article class="post-card">
            <div class="post-meta">
                <time datetime="\(post.publishedAt?.ISO8601Format() ?? "")">\(dateFormatter.string(from: post.publishedAt ?? post.createdAt))</time>
                <span class="post-views">조회 \(post.viewCount)</span>
            </div>
            <h2 class="post-title">
                <a href="/posts/\(post.slug)">\(post.title)</a>
            </h2>
            <p class="post-excerpt">\(post.excerpt)</p>
            <div class="post-tags">
                \(renderPostTags(post.tags))
            </div>
        </article>
        """
    }
    
    public func renderPostDetail(_ post: Post, comments: [Comment] = []) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = config.dateFormat
        
        return """
        <article class="post-detail">
            <header class="post-header">
                <h1 class="post-title">\(post.title)</h1>
                <div class="post-meta">
                    <time datetime="\(post.publishedAt?.ISO8601Format() ?? "")">\(dateFormatter.string(from: post.publishedAt ?? post.createdAt))</time>
                    <span class="post-views">조회 \(post.viewCount)</span>
                    <span class="post-likes">좋아요 \(post.likeCount)</span>
                </div>
                <div class="post-tags">
                    \(renderPostTags(post.tags))
                </div>
            </header>
            
            <div class="post-content">
                \(post.content)
            </div>
            
            <div class="post-actions">
                <button class="like-button" data-post-id="\(post.id)">좋아요</button>
            </div>
            
            \(renderComments(comments))
        </article>
        """
    }
    
    private func renderPostTags(_ tags: [Tag]) -> String {
        var tagLinks = ""
        for tag in tags {
            tagLinks += "<a href=\"/tags/\(tag.slug)\" class=\"tag\">\(tag.name)</a>"
        }
        return tagLinks
    }
    
    // MARK: - Comment Rendering
    
    public func renderComments(_ comments: [Comment]) -> String {
        var content = "<div class=\"comments-section\">"
        content += "<h3>댓글 (\(comments.count))</h3>"
        
        if config.allowComments {
            content += renderCommentForm()
        }
        
        content += "<div class=\"comments-list\">"
        for comment in comments {
            content += renderComment(comment)
        }
        content += "</div>"
        
        content += "</div>"
        return content
    }
    
    public func renderComment(_ comment: Comment) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return """
        <div class="comment" data-comment-id="\(comment.id)">
            <div class="comment-header">
                <strong class="comment-author">\(comment.authorName)</strong>
                <time class="comment-date">\(dateFormatter.string(from: comment.createdAt))</time>
            </div>
            <div class="comment-content">
                \(comment.content)
            </div>
        </div>
        """
    }
    
    public func renderCommentForm() -> String {
        return """
        <form class="comment-form" id="comment-form">
            <div class="form-group">
                <label for="author-name">이름 *</label>
                <input type="text" id="author-name" name="authorName" required>
            </div>
            <div class="form-group">
                <label for="author-email">이메일 *</label>
                <input type="email" id="author-email" name="authorEmail" required>
            </div>
            <div class="form-group">
                <label for="comment-content">댓글 *</label>
                <textarea id="comment-content" name="content" rows="4" required></textarea>
            </div>
            <button type="submit" class="submit-button">댓글 작성</button>
        </form>
        """
    }
    
    // MARK: - Category & Tag Rendering
    
    public func renderCategoryList(_ categories: [Domain.Category]) -> String {
        var content = "<div class=\"category-list\">"
        content += "<h2>카테고리</h2>"
        content += "<ul class=\"category-items\">"
        
        for category in categories {
            content += """
            <li class="category-item">
                <a href="/categories/\(category.slug)">\(category.name)</a>
                <span class="post-count">(\(category.postCount))</span>
            </li>
            """
        }
        
        content += "</ul></div>"
        return content
    }
    
    public func renderTagList(_ tags: [Tag]) -> String {
        var content = "<div class=\"tag-list\">"
        content += "<h2>태그</h2>"
        content += "<div class=\"tag-cloud\">"
        
        for tag in tags {
            content += "<a href=\"/tags/\(tag.slug)\" class=\"tag\">\(tag.name)</a>"
        }
        
        content += "</div></div>"
        return content
    }
    
    // MARK: - Pagination
    
    public func renderPagination(_ pagination: Pagination) -> String {
        var content = "<nav class=\"pagination\">"
        
        if pagination.hasPrevious {
            content += "<a href=\"?page=\(pagination.previousPage!)\" class=\"pagination-link\">이전</a>"
        }
        
        content += "<span class=\"pagination-info\">페이지 \(pagination.page) / \(pagination.totalPages)</span>"
        
        if pagination.hasNext {
            content += "<a href=\"?page=\(pagination.nextPage!)\" class=\"pagination-link\">다음</a>"
        }
        
        content += "</nav>"
        return content
    }
    
    // MARK: - Search
    
    public func renderSearchForm() -> String {
        return """
        <form class="search-form" id="search-form">
            <input type="search" name="query" placeholder="검색어를 입력하세요..." required>
            <button type="submit">검색</button>
        </form>
        """
    }
    
    public func renderSearchResults(query: String, posts: [Post]) -> String {
        var content = "<div class=\"search-results\">"
        content += "<h2>\"\(query)\" 검색 결과 (\(posts.count)개)</h2>"
        
        if posts.isEmpty {
            content += "<p>검색 결과가 없습니다.</p>"
        } else {
            content += renderPostList(posts: posts)
        }
        
        content += "</div>"
        return content
    }
    
    // MARK: - Error Pages
    
    public func renderErrorPage(title: String, content: String) -> String {
        return """
        <div class="error-page">
            <div class="error-content">
                <h1>\(title)</h1>
                <div class="error-message">
                    \(content)
                </div>
                <div class="error-actions">
                    <a href="/" class="btn btn-primary">홈으로 돌아가기</a>
                    <a href="/posts" class="btn btn-secondary">포스트 보기</a>
                </div>
            </div>
        </div>
        """
    }
    
    public func renderNotFoundPage() -> String {
        return renderErrorPage(
            title: "404 - 페이지를 찾을 수 없습니다",
            content: "<p>요청하신 페이지를 찾을 수 없습니다.</p>"
        )
    }
    
    // MARK: - SSG Helper Methods
    
    public func renderHomePage(posts: [Post], categories: [Domain.Category], tags: [Tag], config: BlogConfig?) -> String {
        var content = """
        <div class="home-page">
            <section class="hero">
                <h1>\(config?.siteName ?? "Swift Blog")</h1>
                <p>\(config?.siteDescription ?? "Swift와 Supabase를 사용한 블로그입니다.")</p>
            </section>
            
            <section class="recent-posts">
                <h2>최근 포스트</h2>
                <div class="posts-grid">
        """
        
        for post in posts.prefix(6) {
            content += renderPostCard(post)
        }
        
        content += """
                </div>
            </section>
        </div>
        """
        
        return content
    }
    
    public func renderPostPage(post: Post, comments: [Comment]) -> String {
        var content = """
        <article class="post-detail">
            <header class="post-header">
                <h1>\(post.title)</h1>
                <div class="post-meta">
                    <span>작성자: Jihoon Ahn</span>
                    <span>작성일: \(formatDate(post.publishedAt ?? post.createdAt))</span>
                    <span>조회수: \(post.viewCount)</span>
                </div>
            </header>
            
            <div class="post-content">
                \(post.content)
            </div>
            
            <div class="post-tags">
        """
        
        for tag in post.tags {
            content += "<span class=\"tag\">\(tag.name)</span>"
        }
        
        content += """
            </div>
            
            <div class="post-comments">
                <h3>댓글 (\(comments.count))</h3>
        """
        
        for comment in comments {
            content += renderComment(comment)
        }
        
        content += """
            </div>
        </article>
        """
        
        return content
    }
    
    public func renderCategoryPage(category: Domain.Category, posts: [Post]) -> String {
        var content = """
        <div class="category-page">
            <header class="page-header">
                <h1>\(category.name)</h1>
                <p>\(category.description ?? "")</p>
            </header>
            
            <div class="posts-list">
        """
        
        for post in posts {
            content += renderPostCard(post)
        }
        
        content += """
            </div>
        </div>
        """
        
        return content
    }
    
    public func renderTagPage(tag: Tag, posts: [Post]) -> String {
        var content = """
        <div class="tag-page">
            <header class="page-header">
                <h1>#\(tag.name)</h1>
                <p>\(posts.count)개의 포스트</p>
            </header>
            
            <div class="posts-list">
        """
        
        for post in posts {
            content += renderPostCard(post)
        }
        
        content += """
            </div>
        </div>
        """
        
        return content
    }
    
    
    
    
    public func renderPagination(_ pagination: PaginatedResult<Post>) -> String {
        let totalPages = pagination.pagination.totalPages
        let currentPage = pagination.pagination.page
        
        if totalPages <= 1 {
            return ""
        }
        
        var content = """
        <div class="pagination">
        """
        
        if currentPage > 1 {
            content += "<a href=\"?page=\(currentPage - 1)\" class=\"pagination-link\">이전</a>"
        }
        
        for page in 1...totalPages {
            if page == currentPage {
                content += "<span class=\"pagination-current\">\(page)</span>"
            } else {
                content += "<a href=\"?page=\(page)\" class=\"pagination-link\">\(page)</a>"
            }
        }
        
        if currentPage < totalPages {
            content += "<a href=\"?page=\(currentPage + 1)\" class=\"pagination-link\">다음</a>"
        }
        
        content += "</div>"
        return content
    }
    
    
    public func renderAboutPage() -> String {
        return """
        <div class="about-page">
            <h1>소개</h1>
            <p>Swift WASM과 Supabase를 사용하여 구축된 개인 블로그입니다.</p>
            <h2>기술 스택</h2>
            <ul>
                <li>Swift WASM</li>
                <li>Supabase</li>
                <li>JavaScriptKit</li>
                <li>Tailwind CSS</li>
            </ul>
        </div>
        """
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
