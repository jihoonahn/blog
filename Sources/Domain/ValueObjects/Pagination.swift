import Foundation

public struct Pagination: Codable, Equatable {
    public let page: Int
    public let limit: Int
    public let total: Int
    public let totalPages: Int
    public let hasNext: Bool
    public let hasPrevious: Bool
    public let nextPage: Int?
    public let previousPage: Int?
    
    public init(
        page: Int = 1,
        limit: Int = 10,
        total: Int = 0
    ) {
        self.page = max(1, page)
        self.limit = max(1, min(100, limit)) // 1-100 사이로 제한
        self.total = max(0, total)
        self.totalPages = max(1, Int(ceil(Double(total) / Double(limit))))
        self.hasNext = page < totalPages
        self.hasPrevious = page > 1
        self.nextPage = hasNext ? page + 1 : nil
        self.previousPage = hasPrevious ? page - 1 : nil
    }
    
    public var offset: Int {
        return (page - 1) * limit
    }
    
    public var startIndex: Int {
        return offset + 1
    }
    
    public var endIndex: Int {
        return min(offset + limit, total)
    }
    
    public var isEmpty: Bool {
        return total == 0
    }
}

public struct PaginatedResult<T: Codable>: Codable {
    public let data: [T]
    public let pagination: Pagination
    
    public init(data: [T], pagination: Pagination) {
        self.data = data
        self.pagination = pagination
    }
}

public struct PaginationRequest: Codable {
    public let page: Int
    public let limit: Int
    public let sortBy: String?
    public let sortOrder: SortOrder
    
    public init(
        page: Int = 1,
        limit: Int = 10,
        sortBy: String? = nil,
        sortOrder: SortOrder = .desc
    ) {
        self.page = max(1, page)
        self.limit = max(1, min(100, limit))
        self.sortBy = sortBy
        self.sortOrder = sortOrder
    }
}

public enum SortOrder: String, Codable, CaseIterable {
    case asc = "asc"
    case desc = "desc"
    
    public var displayName: String {
        switch self {
        case .asc: return "오름차순"
        case .desc: return "내림차순"
        }
    }
}
