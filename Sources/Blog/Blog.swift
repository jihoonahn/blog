import Foundation
import Publish
import Plot

struct Blog: Website {
    enum SectionID: String, WebsiteSectionID {
        case blog
        case about

        var name: String {
            switch self {
            case .blog: return "Blog"
            case .about: return "About"
            }
        }
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        var postImage: String
    }
    
    var url = URL(string: "https://blog.jihoon.me")!
    var name = "Jihoonahn Blog"
    var description = "This is a personal blog for iOS Developer Jihoonahn."
    var language: Language { .english }
    var imagePath: Path? { nil }
    var favicon: Favicon? {
        Favicon(path: "/favicon.ico", type: "image/x-icon")
    }
    var socialMediaLinks: [SocialMediaLink] { [.github, .linkedIn, .twitter, .email, .rss] }
}
