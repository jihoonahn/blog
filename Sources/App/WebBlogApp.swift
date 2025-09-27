import Foundation
import Domain

public class WebBlogApp {
    private let domManager: DOMManager
    private let router: Router
    private let adminRouter: AdminRouter
    private let formHandler: FormHandler
    private let jsBridge: JavaScriptBridge
    private let blogManager: BlogManager
    private let htmlRenderer: HTMLRenderer
    private let adminRenderer: AdminRenderer
    private let commentRenderer: CommentRenderer
    private let formRenderer: FormRenderer
    
    public init() {
        // Initialize DOM manager
        self.domManager = DOMManager()
        
        // Initialize router (will be set after htmlRenderer and blogManager are created)
        let tempMockRepo = MockRepository()
        let tempBlogService = BlogService(
            postRepository: tempMockRepo,
            categoryRepository: tempMockRepo,
            tagRepository: tempMockRepo,
            configRepository: tempMockRepo
        )
        let tempAdminService = AdminService(
            adminRepository: tempMockRepo,
            sessionRepository: tempMockRepo,
            postRepository: tempMockRepo,
            commentRepository: tempMockRepo,
            categoryRepository: tempMockRepo,
            tagRepository: tempMockRepo
        )
        let tempCommentService = CommentService(
            commentRepository: tempMockRepo,
            postRepository: tempMockRepo
        )
        let tempAuthService = AuthService(
            adminService: tempAdminService,
            sessionRepository: tempMockRepo
        )
        let tempBlogManager = BlogManager(
            blogService: tempBlogService,
            adminService: tempAdminService,
            commentService: tempCommentService,
            authService: tempAuthService
        )
        
        self.router = Router(domManager: domManager, htmlRenderer: HTMLRenderer(config: BlogConfig()), blogManager: tempBlogManager)
        
        // Initialize admin router
        self.adminRouter = AdminRouter(router: router, domManager: domManager)
        
        // Initialize form handler
        self.formHandler = FormHandler(domManager: domManager, blogManager: tempBlogManager)
        
        // Initialize JavaScript bridge
        self.jsBridge = JavaScriptBridge(domManager: domManager)
        
        // Initialize services (with mock data fallback)
        let mockRepository = MockRepository()
        
        // SSG 모드에서는 Mock Repository 사용
        let blogService = BlogService(
            postRepository: mockRepository,
            categoryRepository: mockRepository,
            tagRepository: mockRepository,
            configRepository: mockRepository
        )
        
        let adminService = AdminService(
            adminRepository: mockRepository,
            sessionRepository: mockRepository,
            postRepository: mockRepository,
            commentRepository: mockRepository,
            categoryRepository: mockRepository,
            tagRepository: mockRepository
        )
        
        let commentService = CommentService(
            commentRepository: mockRepository,
            postRepository: mockRepository
        )
        
        let authService = AuthService(
            adminService: adminService,
            sessionRepository: mockRepository
        )
        
        self.blogManager = BlogManager(
            blogService: blogService,
            adminService: adminService,
            commentService: commentService,
            authService: authService
        )
        
        // Initialize renderers
        let config = BlogConfig()
        self.htmlRenderer = HTMLRenderer(config: config)
        self.adminRenderer = AdminRenderer(htmlRenderer: htmlRenderer)
        self.commentRenderer = CommentRenderer(htmlRenderer: htmlRenderer)
        self.formRenderer = FormRenderer(htmlRenderer: htmlRenderer)
    }
    
    public func start() async {
        // Check if running in SSG mode
        if ProcessInfo.processInfo.environment["SSG_MODE"] == "true" {
            await generateStaticSite()
            return
        }
        
        // Setup JavaScript bridge
        jsBridge.setupBridge()
        
        // Setup form handlers
        formHandler.setupFormHandlers()
        
        // Setup routes
        setupRoutes()
        
        // Setup admin routes
        await adminRouter.setupAdminRoutes()
        
        // Initialize the app
        await initializeApp()
        
        // Start routing
        let currentPath = domManager.getCurrentPath()
        await router.navigate(to: currentPath)
    }
    
    // MARK: - SSG (Static Site Generation)
    
    private func generateStaticSite() async {
        print("🔨 Starting Static Site Generation...")
        
        let outputDir = "Static/dist"
        
        // Create output directory if it doesn't exist
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: outputDir) {
            try? fileManager.createDirectory(atPath: outputDir, withIntermediateDirectories: true)
        }
        
        do {
            // Generate home page
            await generateHomePage(outputDir: outputDir)
            
            // Generate posts pages
            await generatePostsPages(outputDir: outputDir)
            
            // Generate categories pages
            await generateCategoriesPages(outputDir: outputDir)
            
            // Generate tags pages
            await generateTagsPages(outputDir: outputDir)
            
            // Generate about page
            await generateAboutPage(outputDir: outputDir)
            
            print("✅ Static site generation completed!")
            print("📁 Output directory: \(outputDir)")
            
        } catch {
            print("❌ Error during static site generation: \(error)")
        }
    }
    
    private func generateHomePage(outputDir: String) async {
        do {
            let posts = try await blogManager.getPublishedPosts(page: 1, limit: 10)
            let categories = try await blogManager.getAllCategories()
            let tags = try await blogManager.getAllTags()
            let config = try await blogManager.getBlogConfig()
            
            let content = htmlRenderer.renderHomePage(
                posts: posts.data,
                categories: categories,
                tags: tags,
                config: config
            )
            
            let html = htmlRenderer.renderLayout(
                title: config?.siteName ?? "Swift Blog",
                content: content
            )
            
            try html.write(toFile: "\(outputDir)/index.html", atomically: true, encoding: String.Encoding.utf8)
            print("✅ Generated: index.html")
            
        } catch {
            print("❌ Error generating home page: \(error)")
        }
    }
    
    private func generatePostsPages(outputDir: String) async {
        do {
            let posts = try await blogManager.getPublishedPosts(page: 1, limit: 100)
            
            for post in posts.data {
                let comments = try await blogManager.getComments(for: post.id)
                let content = htmlRenderer.renderPostPage(post: post, comments: comments)
                
                let html = htmlRenderer.renderLayout(
                    title: post.title,
                    content: content
                )
                
                let fileName = "\(outputDir)/posts/\(post.slug).html"
                let postDir = "\(outputDir)/posts"
                
                if !FileManager.default.fileExists(atPath: postDir) {
                    try FileManager.default.createDirectory(atPath: postDir, withIntermediateDirectories: true)
                }
                
                try html.write(toFile: fileName, atomically: true, encoding: String.Encoding.utf8)
                print("✅ Generated: posts/\(post.slug).html")
            }
            
        } catch {
            print("❌ Error generating posts pages: \(error)")
        }
    }
    
    private func generateCategoriesPages(outputDir: String) async {
        do {
            let categories = try await blogManager.getAllCategories()
            
            for category in categories {
                let posts = try await blogManager.getPosts(by: category.slug)
                let content = htmlRenderer.renderCategoryPage(category: category, posts: posts)
                
                let html = htmlRenderer.renderLayout(
                    title: "\(category.name) - 카테고리",
                    content: content
                )
                
                let fileName = "\(outputDir)/categories/\(category.slug).html"
                let categoryDir = "\(outputDir)/categories"
                
                if !FileManager.default.fileExists(atPath: categoryDir) {
                    try FileManager.default.createDirectory(atPath: categoryDir, withIntermediateDirectories: true)
                }
                
                try html.write(toFile: fileName, atomically: true, encoding: String.Encoding.utf8)
                print("✅ Generated: categories/\(category.slug).html")
            }
            
        } catch {
            print("❌ Error generating categories pages: \(error)")
        }
    }
    
    private func generateTagsPages(outputDir: String) async {
        do {
            let tags = try await blogManager.getAllTags()
            
            for tag in tags {
                let posts = try await blogManager.getPosts(by: tag.slug)
                let content = htmlRenderer.renderTagPage(tag: tag, posts: posts)
                
                let html = htmlRenderer.renderLayout(
                    title: "\(tag.name) - 태그",
                    content: content
                )
                
                let fileName = "\(outputDir)/tags/\(tag.slug).html"
                let tagDir = "\(outputDir)/tags"
                
                if !FileManager.default.fileExists(atPath: tagDir) {
                    try FileManager.default.createDirectory(atPath: tagDir, withIntermediateDirectories: true)
                }
                
                try html.write(toFile: fileName, atomically: true, encoding: String.Encoding.utf8)
                print("✅ Generated: tags/\(tag.slug).html")
            }
            
        } catch {
            print("❌ Error generating tags pages: \(error)")
        }
    }
    
    private func generateAboutPage(outputDir: String) async {
        let content = htmlRenderer.renderAboutPage()
        
        do {
            let html = htmlRenderer.renderLayout(
                title: "소개",
                content: content
            )
            
            try html.write(toFile: "\(outputDir)/about.html", atomically: true, encoding: String.Encoding.utf8)
            print("✅ Generated: about.html")
            
        } catch {
            print("❌ Error generating about page: \(error)")
        }
    }
    
    private func setupRoutes() {
        // Home route
        router.addRoute(Route(path: "/", name: "home") { [weak self] path, params in
            await self?.handleHomeRoute(path: path, params: params)
        })
        
        // Posts routes
        router.addRoute(Route(path: "/posts", name: "posts") { [weak self] path, params in
            await self?.handlePostsRoute(path: path, params: params)
        })
        
        router.addRoute(Route(path: "/posts/:slug", name: "post-detail") { [weak self] path, params in
            await self?.handlePostDetailRoute(path: path, params: params)
        })
        
        // Categories routes
        router.addRoute(Route(path: "/categories", name: "categories") { [weak self] path, params in
            await self?.handleCategoriesRoute(path: path, params: params)
        })
        
        router.addRoute(Route(path: "/categories/:slug", name: "category-detail") { [weak self] path, params in
            await self?.handleCategoryDetailRoute(path: path, params: params)
        })
        
        // Tags routes
        router.addRoute(Route(path: "/tags", name: "tags") { [weak self] path, params in
            await self?.handleTagsRoute(path: path, params: params)
        })
        
        router.addRoute(Route(path: "/tags/:slug", name: "tag-detail") { [weak self] path, params in
            await self?.handleTagDetailRoute(path: path, params: params)
        })
        
        // Search route
        router.addRoute(Route(path: "/search", name: "search") { [weak self] path, params in
            await self?.handleSearchRoute(path: path, params: params)
        })
        
        // About route
        router.addRoute(Route(path: "/about", name: "about") { [weak self] path, params in
            await self?.handleAboutRoute(path: path, params: params)
        })
        
        // 404 route
        router.addRoute(Route(path: "*", name: "not-found") { [weak self] path, params in
            await self?.handleNotFoundRoute(path: path, params: params)
        })
    }
    
    private func initializeApp() async {
        // Load initial page content
        let content = await loadInitialContent()
        updateMainContent(content)
        
        // Setup global event listeners
        setupGlobalEventListeners()
    }
    
    private func loadInitialContent() async -> String {
        // Load blog entity and render home page
        do {
            let blogEntity = try await blogManager.getBlogEntity()
            let recentPosts = try await blogManager.getRecentPosts(limit: 5)
            
            var content = """
            <div class="home-page">
                <section class="hero-select">
                    <h1>\(blogEntity.config.siteName)</h1>
                    <p>\(blogEntity.config.siteDescription)</p>
                </section>
                
                <section class="recent-posts">
                    <h2>최근 포스트</h2>
                    <div class="posts-grid">
            """
            
            for post in recentPosts {
                content += htmlRenderer.renderPostCard(post)
            }
            
            content += """
                    </div>
                </section>
                
                <section class="blog-stats">
                    <div class="stats-grid">
                        <div class="stat-item">
                            <h3>\(blogEntity.totalPosts)</h3>
                            <p>포스트</p>
                        </div>
                        <div class="stat-item">
                            <h3>\(blogEntity.totalComments)</h3>
                            <p>댓글</p>
                        </div>
                        <div class="stat-item">
                            <h3>\(blogEntity.totalCategories)</h3>
                            <p>카테고리</p>
                        </div>
                        <div class="stat-item">
                            <h3>\(blogEntity.totalTags)</h3>
                            <p>태그</p>
                        </div>
                    </div>
                </section>
            </div>
            """
            
            return htmlRenderer.renderLayout(title: "홈", content: content)
        } catch {
            return htmlRenderer.renderLayout(
                title: "오류",
                content: "<div class='error-page'><h1>페이지를 로드할 수 없습니다</h1><p>\(error.localizedDescription)</p></div>"
            )
        }
    }
    
    private func updateMainContent(_ content: String) {
        print("📝 Updating main content: \(content)")
    }
    
    private func setupGlobalEventListeners() {
        print("👂 Setting up global event listeners for SSG")
    }
    
    private func handleGlobalClick(_ element: [String: Any]) {
        print("🖱️ Handling global click for SSG")
    }
    
    private func handleGlobalFormSubmit(_ form: [String: Any]) {
        print("📝 Handling global form submit for SSG")
    }
    
    private func handlePostLike(postId: String) {
        print("👍 Post like: \(postId)")
    }
    
    private func toggleCommentReply(commentId: String) {
        print("💬 Toggle comment reply: \(commentId)")
    }
    
    // MARK: - Route Handlers
    
    private func handleHomeRoute(path: String, params: [String: String]) async {
        let content = await loadInitialContent()
        updateMainContent(content)
    }
    
    private func handlePostsRoute(path: String, params: [String: String]) async {
        do {
            let posts = try await blogManager.getPublishedPosts(page: 1, limit: 10)
            let content = htmlRenderer.renderPostList(posts: posts.data, pagination: posts.pagination)
            let fullContent = htmlRenderer.renderLayout(title: "포스트", content: content)
            updateMainContent(fullContent)
        } catch {
            showErrorPage(error: error)
        }
    }
    
    private func handlePostDetailRoute(path: String, params: [String: String]) async {
        guard let slug = params["slug"] else {
            showNotFoundPage()
            return
        }
        
        do {
            if let post = try await blogManager.getPost(by: slug) {
                let comments = try await blogManager.getComments(for: post.id)
                let content = htmlRenderer.renderPostDetail(post, comments: comments)
                let fullContent = htmlRenderer.renderLayout(title: post.title, content: content)
                updateMainContent(fullContent)
                
                // Increment view count
                _ = try await blogManager.incrementViewCount(postId: post.id)
            } else {
                showNotFoundPage()
            }
        } catch {
            showErrorPage(error: error)
        }
    }
    
    private func handleCategoriesRoute(path: String, params: [String: String]) async {
        do {
            let categories = try await blogManager.getAllCategories()
            let content = htmlRenderer.renderCategoryList(categories)
            let fullContent = htmlRenderer.renderLayout(title: "카테고리", content: content)
            updateMainContent(fullContent)
        } catch {
            showErrorPage(error: error)
        }
    }
    
    private func handleCategoryDetailRoute(path: String, params: [String: String]) async {
        guard let slug = params["slug"] else {
            showNotFoundPage()
            return
        }
        
        do {
            if let category = try await blogManager.getCategory(by: slug) {
                let posts = try await blogManager.getPosts(by: slug)
                let content = htmlRenderer.renderPostList(posts: posts)
                let fullContent = htmlRenderer.renderLayout(title: category.name, content: content)
                updateMainContent(fullContent)
            } else {
                showNotFoundPage()
            }
        } catch {
            showErrorPage(error: error)
        }
    }
    
    private func handleTagsRoute(path: String, params: [String: String]) async {
        do {
            let tags = try await blogManager.getAllTags()
            let content = htmlRenderer.renderTagList(tags)
            let fullContent = htmlRenderer.renderLayout(title: "태그", content: content)
            updateMainContent(fullContent)
        } catch {
            showErrorPage(error: error)
        }
    }
    
    private func handleTagDetailRoute(path: String, params: [String: String]) async {
        guard let slug = params["slug"] else {
            showNotFoundPage()
            return
        }
        
        do {
            if let tag = try await blogManager.getTag(by: slug) {
                let posts = try await blogManager.getPosts(by: slug)
                let content = htmlRenderer.renderPostList(posts: posts)
                let fullContent = htmlRenderer.renderLayout(title: tag.name, content: content)
                updateMainContent(fullContent)
            } else {
                showNotFoundPage()
            }
        } catch {
            showErrorPage(error: error)
        }
    }
    
    private func handleSearchRoute(path: String, params: [String: String]) async {
        let queryParams = domManager.getQueryParams()
        let query = queryParams["q"] ?? ""
        
        if query.isEmpty {
            let content = htmlRenderer.renderSearchForm()
            let fullContent = htmlRenderer.renderLayout(title: "검색", content: content)
            updateMainContent(fullContent)
        } else {
            do {
                let posts = try await blogManager.searchPosts(query: query)
                let content = htmlRenderer.renderSearchResults(query: query, posts: posts)
                let fullContent = htmlRenderer.renderLayout(title: "검색 결과", content: content)
                updateMainContent(fullContent)
            } catch {
                showErrorPage(error: error)
            }
        }
    }
    
    private func handleAboutRoute(path: String, params: [String: String]) async {
        let content = """
        <div class="about-page">
            <h1>소개</h1>
            <p>이 블로그는 Swift WASM과 Supabase를 사용하여 구축되었습니다.</p>
            <p>개발자: Jihoon Ahn</p>
            <p>기술 스택: Swift, JavaScriptKit, Supabase, Tailwind CSS</p>
        </div>
        """
        let fullContent = htmlRenderer.renderLayout(title: "소개", content: content)
        updateMainContent(fullContent)
    }
    
    private func handleNotFoundRoute(path: String, params: [String: String]) async {
        showNotFoundPage()
    }
    
    // MARK: - Error Handling
    
    private func showErrorPage(error: Error) {
        let content = """
        <div class="error-page">
            <h1>오류가 발생했습니다</h1>
            <p>\(error.localizedDescription)</p>
            <a href="/" class="btn btn-primary">홈으로 돌아가기</a>
        </div>
        """
        let fullContent = htmlRenderer.renderLayout(title: "오류", content: content)
        updateMainContent(fullContent)
    }
    
    private func showNotFoundPage() {
        let content = """
        <div class="error-page">
            <h1>404 - 페이지를 찾을 수 없습니다</h1>
            <p>요청하신 페이지를 찾을 수 없습니다.</p>
            <a href="/" class="btn btn-primary">홈으로 돌아가기</a>
        </div>
        """
        let fullContent = htmlRenderer.renderLayout(title: "페이지를 찾을 수 없습니다", content: content)
        updateMainContent(fullContent)
    }
}
