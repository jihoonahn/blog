import Foundation
import Domain

public class BlogService {
    private let postRepository: PostRepositoryProtocol
    private let categoryRepository: CategoryRepositoryProtocol
    private let tagRepository: TagRepositoryProtocol
    private let configRepository: BlogConfigRepositoryProtocol
    
    public init(
        postRepository: PostRepositoryProtocol,
        categoryRepository: CategoryRepositoryProtocol,
        tagRepository: TagRepositoryProtocol,
        configRepository: BlogConfigRepositoryProtocol
    ) {
        self.postRepository = postRepository
        self.categoryRepository = categoryRepository
        self.tagRepository = tagRepository
        self.configRepository = configRepository
    }
    
    // MARK: - Public Methods
    
    public func getBlogEntity() async throws -> BlogEntity {
        let config = try await configRepository.getConfig() ?? BlogConfig()
        let publishedPosts = try await postRepository.getPublishedPosts()
        let categories = try await categoryRepository.getAllCategories()
        let tags = try await tagRepository.getAllTags()
        let recentPosts = try await postRepository.getRecentPosts(limit: 5)
        let popularPosts = try await postRepository.getPopularPosts(limit: 5)
        
        return BlogEntity(
            config: config,
            totalPosts: publishedPosts.count,
            totalComments: 0, // TODO: Implement comment count
            totalCategories: categories.count,
            totalTags: tags.count,
            recentPosts: recentPosts,
            popularPosts: popularPosts,
            categories: categories,
            tags: tags
        )
    }
    
    public func getPublishedPosts(page: Int = 1, limit: Int = 10) async throws -> PaginatedResult<Post> {
        let allPosts = try await postRepository.getPublishedPosts()
        let pagination = Pagination(page: page, limit: limit, total: allPosts.count)
        
        let startIndex = pagination.offset
        let endIndex = min(startIndex + limit, allPosts.count)
        let posts = Array(allPosts[startIndex..<endIndex])
        
        return PaginatedResult(data: posts, pagination: pagination)
    }
    
    public func getPost(by slug: String) async throws -> Post? {
        return try await postRepository.getPost(by: slug)
    }
    
    public func getPost(by id: UUID) async throws -> Post? {
        return try await postRepository.getPost(by: id)
    }
    
    public func getPosts(by categorySlug: String) async throws -> [Post] {
        guard let category = try await categoryRepository.getCategory(by: categorySlug) else {
            return []
        }
        return try await postRepository.getPostsByCategory(categoryId: category.id)
    }
    
    
    public func searchPosts(query: String) async throws -> [Post] {
        return try await postRepository.searchPosts(query: query)
    }
    
    public func getRecentPosts(limit: Int = 5) async throws -> [Post] {
        return try await postRepository.getRecentPosts(limit: limit)
    }
    
    public func getPopularPosts(limit: Int = 5) async throws -> [Post] {
        return try await postRepository.getPopularPosts(limit: limit)
    }
    
    public func getAllCategories() async throws -> [Domain.Category] {
        return try await categoryRepository.getAllCategories()
    }
    
    public func getAllTags() async throws -> [Tag] {
        return try await tagRepository.getAllTags()
    }
    
    public func getCategory(by slug: String) async throws -> Domain.Category? {
        return try await categoryRepository.getCategory(by: slug)
    }
    
    public func getTag(by slug: String) async throws -> Tag? {
        return try await tagRepository.getTag(by: slug)
    }
    
    public func incrementViewCount(postId: UUID) async throws -> Bool {
        return try await postRepository.incrementViewCount(postId: postId)
    }
    
    public func incrementLikeCount(postId: UUID) async throws -> Bool {
        return try await postRepository.incrementLikeCount(postId: postId)
    }
    
    public func getBlogConfig() async throws -> BlogConfig? {
        return try await configRepository.getConfig()
    }
}