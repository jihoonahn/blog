import Foundation
import Publish
import Plot

struct Blog: Website {
    enum SectionID: String, WebsiteSectionID {
        case blog
        case dev
        case about
        case contact

        var name: String {
            switch self {
            case .blog: return "Blog"
            case .dev: return "Dev"
            case .about: return "About"
            case .contact: return "Contact"
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
