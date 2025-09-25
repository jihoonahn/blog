import Vapor

enum ImageType: String, Codable, CaseIterable {
    case featured = "featured"
    case content = "content"
    
    var maxFileSize: Int {
        switch self {
        case .featured: return 5 * 1024 * 1024
        case .content: return 10 * 1024 * 1024
        }
    }
    
    var allowedMimeTypes: [String] {
        return ["image/jpeg", "image/png", "image/gif", "image/webp"]
    }
    
    var uploadPath: String {
        switch self {
        case .featured: return "uploads/featured/"
        case .content: return "uploads/content/"
        }
    }
}
