@main
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
    var name = "Jihoon.me"
    var description = "This is a personal blog for iOS Developer Jihoonahn."
    var language: Language { .english }
    var imagePath: Path? { nil }
    var favicon: Favicon? { Favicon(path: "/favicon.ico", type: "image/x-icon") }
    var socialMediaLinks: [SocialMediaLink] { [.github, .linkedIn, .email, .rss] }
    static let tailwind = SwiftyTailwind()
    
    static func main() throws {
        try Blog().publish(using: [
            .installPlugin(
                .init(name: "Tailwind", installer: { context in
                    let rootDirectory = try! AbsolutePath(validating: try context.folder(at: "/").path)
                    try await tailwind.run(input: rootDirectory.appending(components: ["Style", "input.css"]),
                                           output: rootDirectory.appending(components: ["Output", "output.css"]))
                })
            ),
            .optional(.copyResources()),
            .addMarkdownFiles(),
            .group([.generatePaginatedPages()]),
            .generateHTML(withTheme: .blog),
            .generateRSSFeed(including: [.blog]),
            .generateSiteMap(),
            .deploy(using: .gitHub("Jihoonahn/Blog"))
        ])
    }
}
