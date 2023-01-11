import Foundation
import Publish
import Plot

struct Blog: Website {
    enum SectionID: String, WebsiteSectionID {
        case blog
        case dev
        case info
        case about

        var name: String {
            switch self {
            case .blog: return "Blog"
            case .dev: return "Dev"
            case .info: return "Info"
            case .about: return "About"
            }
        }
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }
    
    var url = URL(string: "https://blog.jihoon.me")!
    var name = "JiHoonAHN Blog"
    var description = "This is a personal blog for iOS Developer JiHoonAHN."
    var language: Language { .english }
    var imagePath: Path? { nil }
    var favicon: Favicon? {
        Favicon(path: "/favicon.ico", type: "image/x-icon")
    }
    var socialMediaLinks: [SocialMediaLink] { [.github, .stackoverflow, .twitter, .email] }
}
