import Foundation

// MARK: - Post Repository Protocol
public protocol PostRepositoryProtocol {
    func getAllPosts() async throws -> [Post]
    func getPublishedPosts() async throws -> [Post]
    func getPost(by id: UUID) async throws -> Post?
    func getPost(by slug: String) async throws -> Post?
    func getPostsByCategory(categoryId: UUID) async throws -> [Post]
    func getPostsByTag(tagId: UUID) async throws -> [Post]
    func getPostsByAuthor(authorId: UUID) async throws -> [Post]
    func searchPosts(query: String) async throws -> [Post]
    func getRecentPosts(limit: Int) async throws -> [Post]
    func getPopularPosts(limit: Int) async throws -> [Post]
    func createPost(_ post: Post) async throws -> Post
    func updatePost(_ post: Post) async throws -> Post
    func deletePost(id: UUID) async throws -> Bool
    func incrementViewCount(postId: UUID) async throws -> Bool
    func incrementLikeCount(postId: UUID) async throws -> Bool
}

// MARK: - Comment Repository Protocol
public protocol CommentRepositoryProtocol {
    func getAllComments() async throws -> [Comment]
    func getComments(by postId: UUID) async throws -> [Comment]
    func getApprovedComments(by postId: UUID) async throws -> [Comment]
    func getComment(by id: UUID) async throws -> Comment?
    func getComments(by status: CommentStatus) async throws -> [Comment]
    func createComment(_ comment: Comment) async throws -> Comment
    func updateComment(_ comment: Comment) async throws -> Comment
    func deleteComment(id: UUID) async throws -> Bool
    func approveComment(id: UUID) async throws -> Bool
    func rejectComment(id: UUID) async throws -> Bool
    func markAsSpam(id: UUID) async throws -> Bool
}

// MARK: - Category Repository Protocol
public protocol CategoryRepositoryProtocol {
    func getAllCategories() async throws -> [Category]
    func getCategory(by id: UUID) async throws -> Category?
    func getCategory(by slug: String) async throws -> Category?
    func getTopLevelCategories() async throws -> [Category]
    func getSubCategories(parentId: UUID) async throws -> [Category]
    func createCategory(_ category: Category) async throws -> Category
    func updateCategory(_ category: Category) async throws -> Category
    func deleteCategory(id: UUID) async throws -> Bool
}

// MARK: - Tag Repository Protocol
public protocol TagRepositoryProtocol {
    func getAllTags() async throws -> [Tag]
    func getTag(by id: UUID) async throws -> Tag?
    func getTag(by slug: String) async throws -> Tag?
    func getPopularTags(limit: Int) async throws -> [Tag]
    func createTag(_ tag: Tag) async throws -> Tag
    func updateTag(_ tag: Tag) async throws -> Tag
    func deleteTag(id: UUID) async throws -> Bool
}

// MARK: - Admin Repository Protocol
public protocol AdminRepositoryProtocol {
    func getAllAdmins() async throws -> [Admin]
    func getAdmin(by id: UUID) async throws -> Admin?
    func getAdminByUsername(username: String) async throws -> Admin?
    func getAdminByEmail(email: String) async throws -> Admin?
    func createAdmin(_ admin: Admin) async throws -> Admin
    func updateAdmin(_ admin: Admin) async throws -> Admin
    func deleteAdmin(id: UUID) async throws -> Bool
    func updateLastLogin(adminId: UUID) async throws -> Bool
}

// MARK: - Blog Config Repository Protocol
public protocol BlogConfigRepositoryProtocol {
    func getConfig() async throws -> BlogConfig?
    func updateConfig(_ config: BlogConfig) async throws -> BlogConfig
    func createConfig(_ config: BlogConfig) async throws -> BlogConfig
}

// MARK: - Session Repository Protocol
public protocol SessionRepositoryProtocol {
    func createSession(_ session: AdminSession) async throws -> AdminSession
    func getSession(by token: String) async throws -> AdminSession?
    func updateSession(_ session: AdminSession) async throws -> AdminSession
    func deleteSession(token: String) async throws -> Bool
    func deleteExpiredSessions() async throws -> Int
}
