import Foundation

// Mock Repository - Supabase 연결이 실패할 때 사용하는 Mock Data Repository
public class MockRepository: PostRepositoryProtocol, CommentRepositoryProtocol, CategoryRepositoryProtocol, TagRepositoryProtocol, AdminRepositoryProtocol, BlogConfigRepositoryProtocol, SessionRepositoryProtocol {
    
    public init() {}
    
    // MARK: - PostRepositoryProtocol Implementation
    
    public func getAllPosts() async throws -> [Post] {
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1초
        return MockDataProvider.mockPosts
    }
    
    public func getPublishedPosts() async throws -> [Post] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockPosts.filter { $0.status == .published }
    }
    
    public func getPost(by id: UUID) async throws -> Post? {
        try await Task.sleep(nanoseconds: 50_000_000) // 0.05초
        return MockDataProvider.mockPosts.first { $0.id == id && $0.status == .published }
    }
    
    public func getPost(by slug: String) async throws -> Post? {
        try await Task.sleep(nanoseconds: 50_000_000)
        return MockDataProvider.mockPosts.first { $0.slug == slug && $0.status == .published }
    }
    
    public func getPostsByCategory(categoryId: UUID) async throws -> [Post] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockPosts.filter {
            $0.categoryId == categoryId && $0.status == .published
        }
    }
    
    public func getPostsByTag(tagId: UUID) async throws -> [Post] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockPosts.filter {
            $0.tags.contains { $0.id == tagId } && $0.status == .published
        }
    }
    
    public func getPostsByAuthor(authorId: UUID) async throws -> [Post] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockPosts.filter {
            $0.authorId == authorId && $0.status == .published
        }
    }
    
    public func searchPosts(query: String) async throws -> [Post] {
        try await Task.sleep(nanoseconds: 150_000_000)
        return MockDataProvider.searchPosts(query: query)
    }
    
    public func getRecentPosts(limit: Int) async throws -> [Post] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockPosts
            .filter { $0.status == .published }
            .sorted { $0.createdAt > $1.createdAt }
            .prefix(limit)
            .map { $0 }
    }
    
    public func getPopularPosts(limit: Int) async throws -> [Post] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockPosts
            .filter { $0.status == .published }
            .sorted { $0.viewCount > $1.viewCount }
            .prefix(limit)
            .map { $0 }
    }
    
    public func createPost(_ post: Post) async throws -> Post {
        fatalError("MockRepository does not support createPost")
    }
    
    public func updatePost(_ post: Post) async throws -> Post {
        fatalError("MockRepository does not support updatePost")
    }
    
    public func deletePost(id: UUID) async throws -> Bool {
        fatalError("MockRepository does not support deletePost")
    }
    
    public func incrementViewCount(postId: UUID) async throws -> Bool {
        return true // Simulate success
    }
    
    public func incrementLikeCount(postId: UUID) async throws -> Bool {
        return true // Simulate success
    }
    
    // MARK: - CommentRepositoryProtocol Implementation
    
    public func getAllComments() async throws -> [Comment] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockComments
    }
    
    public func getComments(by postId: UUID) async throws -> [Comment] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockComments.filter { $0.postId == postId }
    }
    
    public func getApprovedComments(by postId: UUID) async throws -> [Comment] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockComments.filter { $0.postId == postId && $0.status == .approved }
    }
    
    public func getComment(by id: UUID) async throws -> Comment? {
        try await Task.sleep(nanoseconds: 50_000_000)
        return MockDataProvider.mockComments.first { $0.id == id }
    }
    
    public func getComments(by status: CommentStatus) async throws -> [Comment] {
        try await Task.sleep(nanoseconds: 100_000_000)
        return MockDataProvider.mockComments.filter { $0.status == status }
    }
    
    public func createComment(_ comment: Comment) async throws -> Comment {
        fatalError("MockRepository does not support createComment")
    }
    
    public func updateComment(_ comment: Comment) async throws -> Comment {
        fatalError("MockRepository does not support updateComment")
    }
    
    public func deleteComment(id: UUID) async throws -> Bool {
        fatalError("MockRepository does not support deleteComment")
    }
    
    public func approveComment(id: UUID) async throws -> Bool {
        return true // Simulate success
    }
    
    public func rejectComment(id: UUID) async throws -> Bool {
        return true // Simulate success
    }
    
    public func markAsSpam(id: UUID) async throws -> Bool {
        return true // Simulate success
    }
    
    // MARK: - CategoryRepositoryProtocol Implementation
    
    public func getAllCategories() async throws -> [Category] {
        try await Task.sleep(nanoseconds: 50_000_000)
        return MockDataProvider.mockCategories
    }
    
    public func getCategory(by id: UUID) async throws -> Category? {
        try await Task.sleep(nanoseconds: 20_000_000)
        return MockDataProvider.mockCategories.first { $0.id == id }
    }
    
    public func getCategory(by slug: String) async throws -> Category? {
        try await Task.sleep(nanoseconds: 20_000_000)
        return MockDataProvider.mockCategories.first { $0.slug == slug }
    }
    
    public func getTopLevelCategories() async throws -> [Category] {
        try await Task.sleep(nanoseconds: 50_000_000)
        return MockDataProvider.mockCategories // Assuming all are top-level for mock
    }
    
    public func getSubCategories(parentId: UUID) async throws -> [Category] {
        return [] // No subcategories in mock
    }
    
    public func createCategory(_ category: Category) async throws -> Category {
        fatalError("MockRepository does not support createCategory")
    }
    
    public func updateCategory(_ category: Category) async throws -> Category {
        fatalError("MockRepository does not support updateCategory")
    }
    
    public func deleteCategory(id: UUID) async throws -> Bool {
        fatalError("MockRepository does not support deleteCategory")
    }
    
    // MARK: - TagRepositoryProtocol Implementation
    
    public func getAllTags() async throws -> [Tag] {
        try await Task.sleep(nanoseconds: 50_000_000)
        return MockDataProvider.mockTags
    }
    
    public func getTag(by id: UUID) async throws -> Tag? {
        try await Task.sleep(nanoseconds: 20_000_000)
        return MockDataProvider.mockTags.first { $0.id == id }
    }
    
    public func getTag(by slug: String) async throws -> Tag? {
        try await Task.sleep(nanoseconds: 20_000_000)
        return MockDataProvider.mockTags.first { $0.slug == slug }
    }
    
    public func getPopularTags(limit: Int) async throws -> [Tag] {
        try await Task.sleep(nanoseconds: 50_000_000)
        return Array(MockDataProvider.mockTags.prefix(limit)) // Simple mock for popular
    }
    
    public func createTag(_ tag: Tag) async throws -> Tag {
        fatalError("MockRepository does not support createTag")
    }
    
    public func updateTag(_ tag: Tag) async throws -> Tag {
        fatalError("MockRepository does not support updateTag")
    }
    
    public func deleteTag(id: UUID) async throws -> Bool {
        fatalError("MockRepository does not support deleteTag")
    }
    
    // MARK: - AdminRepositoryProtocol Implementation
    
    public func getAllAdmins() async throws -> [Admin] {
        try await Task.sleep(nanoseconds: 50_000_000)
        return [MockDataProvider.mockAdmin]
    }
    
    public func getAdmin(by id: UUID) async throws -> Admin? {
        try await Task.sleep(nanoseconds: 20_000_000)
        return MockDataProvider.mockAdmin.id == id ? MockDataProvider.mockAdmin : nil
    }
    
    public func getAdminByUsername(username: String) async throws -> Admin? {
        try await Task.sleep(nanoseconds: 20_000_000)
        return MockDataProvider.mockAdmin.username == username ? MockDataProvider.mockAdmin : nil
    }
    
    public func getAdminByEmail(email: String) async throws -> Admin? {
        try await Task.sleep(nanoseconds: 20_000_000)
        return MockDataProvider.mockAdmin.email == email ? MockDataProvider.mockAdmin : nil
    }
    
    public func createAdmin(_ admin: Admin) async throws -> Admin {
        fatalError("MockRepository does not support createAdmin")
    }
    
    public func updateAdmin(_ admin: Admin) async throws -> Admin {
        fatalError("MockRepository does not support updateAdmin")
    }
    
    public func deleteAdmin(id: UUID) async throws -> Bool {
        fatalError("MockRepository does not support deleteAdmin")
    }
    
    public func updateLastLogin(adminId: UUID) async throws -> Bool {
        return true // Simulate success
    }
    
    // MARK: - BlogConfigRepositoryProtocol Implementation
    
    public func getConfig() async throws -> BlogConfig? {
        try await Task.sleep(nanoseconds: 50_000_000)
        return MockDataProvider.mockBlogConfig
    }
    
    public func getBlogConfig() async throws -> BlogConfig? {
        try await Task.sleep(nanoseconds: 50_000_000)
        return MockDataProvider.mockBlogConfig
    }
    
    public func updateConfig(_ config: BlogConfig) async throws -> BlogConfig {
        fatalError("MockRepository does not support updateConfig")
    }
    
    public func createConfig(_ config: BlogConfig) async throws -> BlogConfig {
        fatalError("MockRepository does not support createConfig")
    }
    
    // MARK: - SessionRepositoryProtocol Implementation
    
    public func createSession(_ session: AdminSession) async throws -> AdminSession {
        fatalError("MockRepository does not support createSession")
    }
    
    public func getSession(by token: String) async throws -> AdminSession? {
        fatalError("MockRepository does not support getSession")
    }
    
    public func updateSession(_ session: AdminSession) async throws -> AdminSession {
        fatalError("MockRepository does not support updateSession")
    }
    
    public func deleteSession(token: String) async throws -> Bool {
        fatalError("MockRepository does not support deleteSession")
    }
    
    public func deleteExpiredSessions() async throws -> Int {
        return 0 // Simulate no expired sessions
    }
}