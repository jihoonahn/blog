import Vapor

enum PostStatus: String, Codable, CaseIterable {
    case draft = "draft"
    case published = "published"
    case archived = "archived"
    
    var displayName: String {
        self.rawValue
    }
}
