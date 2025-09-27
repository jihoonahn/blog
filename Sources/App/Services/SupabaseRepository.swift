import Foundation
import Domain
import Supabase

public class SupabaseRepository: PostRepositoryProtocol, CommentRepositoryProtocol, CategoryRepositoryProtocol, TagRepositoryProtocol, AdminRepositoryProtocol, BlogConfigRepositoryProtocol, SessionRepositoryProtocol {
    private let supabase: SupabaseClient
    
    public init(supabaseURL: String, supabaseKey: String) {
        self.supabase = SupabaseClient(supabaseURL: URL(string: supabaseURL)!, supabaseKey: supabaseKey)
    }
    
    // MARK: - PostRepositoryProtocol
    
    public func getAllPosts() async throws -> [Post] {
        let response: [Post] = try await supabase.database
            .from("posts")
            .select()
            .execute()
            .value
        return response
    }
    
    public func getPublishedPosts() async throws -> [Post] {
        let response: [Post] = try await supabase.database
            .from("posts")
            .select()
            .eq("status", value: "published")
            .execute()
            .value
        return response
    }
    
    public func getPost(by id: UUID) async throws -> Post? {
        let response: Post? = try await supabase.database
            .from("posts")
            .select()
            .eq("id", value: id)
            .single()
            .execute()
            .value
        return response
    }
    
    public func getPost(by slug: String) async throws -> Post? {
        let response: Post? = try await supabase.database
            .from("posts")
            .select()
            .eq("slug", value: slug)
            .single()
            .execute()
            .value
        return response
    }
    
    public func getPostsByCategory(categoryId: UUID) async throws -> [Post] {
        let response: [Post] = try await supabase.database
            .from("posts")
            .select()
            .eq("category_id", value: categoryId)
            .eq("status", value: "published")
            .execute()
            .value
        return response
    }
    
    public func getPostsByTag(tagId: UUID) async throws -> [Post] {
        let response: [Post] = try await supabase.database
            .from("posts")
            .select()
            .contains("tags", value: [tagId])
            .eq("status", value: "published")
            .execute()
            .value
        return response
    }
    
    public func getPostsByAuthor(authorId: UUID) async throws -> [Post] {
        let response: [Post] = try await supabase.database
            .from("posts")
            .select()
            .eq("author_id", value: authorId)
            .eq("status", value: "published")
            .execute()
            .value
        return response
    }
    
    public func searchPosts(query: String) async throws -> [Post] {
        let response: [Post] = try await supabase.database
            .from("posts")
            .select()
            .or("title.ilike.%\(query)%,content.ilike.%\(query)%")
            .eq("status", value: "published")
            .execute()
            .value
        return response
    }
    
    public func getRecentPosts(limit: Int) async throws -> [Post] {
        let response: [Post] = try await supabase.database
            .from("posts")
            .select()
            .eq("status", value: "published")
            .order("created_at", ascending: false)
            .limit(limit)
            .execute()
            .value
        return response
    }
    
    public func getPopularPosts(limit: Int) async throws -> [Post] {
        let response: [Post] = try await supabase.database
            .from("posts")
            .select()
            .eq("status", value: "published")
            .order("view_count", ascending: false)
            .limit(limit)
            .execute()
            .value
        return response
    }
    
    public func createPost(_ post: Post) async throws -> Post {
        let response: Post = try await supabase.database
            .from("posts")
            .insert(post)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func updatePost(_ post: Post) async throws -> Post {
        let response: Post = try await supabase.database
            .from("posts")
            .update(post)
            .eq("id", value: post.id)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func deletePost(id: UUID) async throws -> Bool {
        try await supabase.database
            .from("posts")
            .delete()
            .eq("id", value: id)
            .execute()
        return true
    }
    
    public func incrementViewCount(postId: UUID) async throws -> Bool {
        try await supabase.database
            .from("posts")
            .update(["view_count": "view_count + 1"])
            .eq("id", value: postId)
            .execute()
        return true
    }
    
    public func incrementLikeCount(postId: UUID) async throws -> Bool {
        try await supabase.database
            .from("posts")
            .update(["like_count": "like_count + 1"])
            .eq("id", value: postId)
            .execute()
        return true
    }
    
    // MARK: - CommentRepositoryProtocol
    
    public func getAllComments() async throws -> [Comment] {
        let response: [Comment] = try await supabase.database
            .from("comments")
            .select()
            .execute()
            .value
        return response
    }
    
    public func getComments(by postId: UUID) async throws -> [Comment] {
        let response: [Comment] = try await supabase.database
            .from("comments")
            .select()
            .eq("post_id", value: postId)
            .execute()
            .value
        return response
    }
    
    public func getApprovedComments(by postId: UUID) async throws -> [Comment] {
        let response: [Comment] = try await supabase.database
            .from("comments")
            .select()
            .eq("post_id", value: postId)
            .eq("status", value: "approved")
            .execute()
            .value
        return response
    }
    
    public func getComment(by id: UUID) async throws -> Comment? {
        let response: Comment? = try await supabase.database
            .from("comments")
            .select()
            .eq("id", value: id)
            .single()
            .execute()
            .value
        return response
    }
    
    public func getComments(by status: CommentStatus) async throws -> [Comment] {
        let response: [Comment] = try await supabase.database
            .from("comments")
            .select()
            .eq("status", value: status.rawValue)
            .execute()
            .value
        return response
    }
    
    public func createComment(_ comment: Comment) async throws -> Comment {
        let response: Comment = try await supabase.database
            .from("comments")
            .insert(comment)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func updateComment(_ comment: Comment) async throws -> Comment {
        let response: Comment = try await supabase.database
            .from("comments")
            .update(comment)
            .eq("id", value: comment.id)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func deleteComment(id: UUID) async throws -> Bool {
        try await supabase.database
            .from("comments")
            .delete()
            .eq("id", value: id)
            .execute()
        return true
    }
    
    public func approveComment(id: UUID) async throws -> Bool {
        try await supabase.database
            .from("comments")
            .update(["status": "approved"])
            .eq("id", value: id)
            .execute()
        return true
    }
    
    public func rejectComment(id: UUID) async throws -> Bool {
        try await supabase.database
            .from("comments")
            .update(["status": "rejected"])
            .eq("id", value: id)
            .execute()
        return true
    }
    
    public func markAsSpam(id: UUID) async throws -> Bool {
        try await supabase.database
            .from("comments")
            .update(["status": "spam"])
            .eq("id", value: id)
            .execute()
        return true
    }
    
    // MARK: - CategoryRepositoryProtocol
    
    public func getAllCategories() async throws -> [Domain.Category] {
        let response: [Domain.Category] = try await supabase.database
            .from("categories")
            .select()
            .execute()
            .value
        return response
    }
    
    public func getCategory(by id: UUID) async throws -> Domain.Category? {
        let response: Domain.Category? = try await supabase.database
            .from("categories")
            .select()
            .eq("id", value: id)
            .single()
            .execute()
            .value
        return response
    }
    
    public func getCategory(by slug: String) async throws -> Domain.Category? {
        let response: Domain.Category? = try await supabase.database
            .from("categories")
            .select()
            .eq("slug", value: slug)
            .single()
            .execute()
            .value
        return response
    }
    
    public func getTopLevelCategories() async throws -> [Domain.Category] {
        let response: [Domain.Category] = try await supabase.database
            .from("categories")
            .select()
            .is("parent_id", value: nil)
            .execute()
            .value
        return response
    }
    
    public func getSubCategories(parentId: UUID) async throws -> [Domain.Category] {
        let response: [Domain.Category] = try await supabase.database
            .from("categories")
            .select()
            .eq("parent_id", value: parentId)
            .execute()
            .value
        return response
    }
    
    public func createCategory(_ category: Domain.Category) async throws -> Domain.Category {
        let response: Domain.Category = try await supabase.database
            .from("categories")
            .insert(category)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func updateCategory(_ category: Domain.Category) async throws -> Domain.Category {
        let response: Domain.Category = try await supabase.database
            .from("categories")
            .update(category)
            .eq("id", value: category.id)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func deleteCategory(id: UUID) async throws -> Bool {
        try await supabase.database
            .from("categories")
            .delete()
            .eq("id", value: id)
            .execute()
        return true
    }
    
    // MARK: - TagRepositoryProtocol
    
    public func getAllTags() async throws -> [Tag] {
        let response: [Tag] = try await supabase.database
            .from("tags")
            .select()
            .execute()
            .value
        return response
    }
    
    public func getTag(by id: UUID) async throws -> Tag? {
        let response: Tag? = try await supabase.database
            .from("tags")
            .select()
            .eq("id", value: id)
            .single()
            .execute()
            .value
        return response
    }
    
    public func getTag(by slug: String) async throws -> Tag? {
        let response: Tag? = try await supabase.database
            .from("tags")
            .select()
            .eq("slug", value: slug)
            .single()
            .execute()
            .value
        return response
    }
    
    public func getPopularTags(limit: Int) async throws -> [Tag] {
        let response: [Tag] = try await supabase.database
            .from("tags")
            .select()
            .order("usage_count", ascending: false)
            .limit(limit)
            .execute()
            .value
        return response
    }
    
    public func createTag(_ tag: Tag) async throws -> Tag {
        let response: Tag = try await supabase.database
            .from("tags")
            .insert(tag)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func updateTag(_ tag: Tag) async throws -> Tag {
        let response: Tag = try await supabase.database
            .from("tags")
            .update(tag)
            .eq("id", value: tag.id)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func deleteTag(id: UUID) async throws -> Bool {
        try await supabase.database
            .from("tags")
            .delete()
            .eq("id", value: id)
            .execute()
        return true
    }
    
    // MARK: - AdminRepositoryProtocol
    
    public func getAllAdmins() async throws -> [Admin] {
        let response: [Admin] = try await supabase.database
            .from("admins")
            .select()
            .execute()
            .value
        return response
    }
    
    public func getAdmin(by id: UUID) async throws -> Admin? {
        let response: Admin? = try await supabase.database
            .from("admins")
            .select()
            .eq("id", value: id)
            .single()
            .execute()
            .value
        return response
    }
    
    public func getAdminByUsername(username: String) async throws -> Admin? {
        let response: Admin? = try await supabase.database
            .from("admins")
            .select()
            .eq("username", value: username)
            .single()
            .execute()
            .value
        return response
    }
    
    public func getAdminByEmail(email: String) async throws -> Admin? {
        let response: Admin? = try await supabase.database
            .from("admins")
            .select()
            .eq("email", value: email)
            .single()
            .execute()
            .value
        return response
    }
    
    public func createAdmin(_ admin: Admin) async throws -> Admin {
        let response: Admin = try await supabase.database
            .from("admins")
            .insert(admin)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func updateAdmin(_ admin: Admin) async throws -> Admin {
        let response: Admin = try await supabase.database
            .from("admins")
            .update(admin)
            .eq("id", value: admin.id)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func deleteAdmin(id: UUID) async throws -> Bool {
        try await supabase.database
            .from("admins")
            .delete()
            .eq("id", value: id)
            .execute()
        return true
    }
    
    public func updateLastLogin(adminId: UUID) async throws -> Bool {
        try await supabase.database
            .from("admins")
            .update(["last_login_at": Date()])
            .eq("id", value: adminId)
            .execute()
        return true
    }
    
    // MARK: - BlogConfigRepositoryProtocol
    
    public func getConfig() async throws -> BlogConfig? {
        let response: BlogConfig? = try await supabase.database
            .from("blog_config")
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func updateConfig(_ config: BlogConfig) async throws -> BlogConfig {
        let response: BlogConfig = try await supabase.database
            .from("blog_config")
            .update(config)
            .eq("id", value: config.id)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func createConfig(_ config: BlogConfig) async throws -> BlogConfig {
        let response: BlogConfig = try await supabase.database
            .from("blog_config")
            .insert(config)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    // MARK: - SessionRepositoryProtocol
    
    public func createSession(_ session: AdminSession) async throws -> AdminSession {
        let response: AdminSession = try await supabase.database
            .from("admin_sessions")
            .insert(session)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func getSession(by token: String) async throws -> AdminSession? {
        let response: AdminSession? = try await supabase.database
            .from("admin_sessions")
            .select()
            .eq("token", value: token)
            .single()
            .execute()
            .value
        return response
    }
    
    public func updateSession(_ session: AdminSession) async throws -> AdminSession {
        let response: AdminSession = try await supabase.database
            .from("admin_sessions")
            .update(session)
            .eq("id", value: session.id)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    public func deleteSession(token: String) async throws -> Bool {
        try await supabase.database
            .from("admin_sessions")
            .delete()
            .eq("token", value: token)
            .execute()
        return true
    }
    
    public func deleteExpiredSessions() async throws -> Int {
        let response: [AdminSession] = try await supabase.database
            .from("admin_sessions")
            .select()
            .lt("expires_at", value: Date())
            .execute()
            .value
        
        for session in response {
            try await deleteSession(token: session.token)
        }
        
        return response.count
    }
}
