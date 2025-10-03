import Foundation
import Web

public struct PaginatedPosts: Sendable {
    public let posts: [Post]
    public let currentPage: Int
    public let totalPages: Int
    public let hasNextPage: Bool
    public let hasPreviousPage: Bool
    public let nextPageNumber: Int?
    public let previousPageNumber: Int?
    
    public init(posts: [Post], currentPage: Int, postsPerPage: Int) {
        let totalPosts = posts.count
        let totalPages = max(1, Int(ceil(Double(totalPosts) / Double(postsPerPage))))
        
        let startIndex = (currentPage - 1) * postsPerPage
        let endIndex = min(startIndex + postsPerPage, totalPosts)
        
        self.posts = Array(posts[startIndex..<endIndex])
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.hasNextPage = currentPage < totalPages
        self.hasPreviousPage = currentPage > 1
        self.nextPageNumber = hasNextPage ? currentPage + 1 : nil
        self.previousPageNumber = hasPreviousPage ? currentPage - 1 : nil
    }
}
