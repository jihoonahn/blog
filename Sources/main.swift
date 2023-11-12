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
    var name = "blog.jihoon.me"
    var description = "This is a personal blog for iOS Developer Jihoonahn."
    var language: Language { .english }
    var imagePath: Path? { nil }
    var favicon: Favicon? { Favicon(path: "/favicon.ico", type: "image/x-icon") }
    var socialMediaLinks: [SocialMediaLink] { [.github, .linkedIn, .email, .rss] }
}

try Blog().publish(
    withTheme: .blog,
    deployedUsing: .gitHub("jihoonahn/blog"),
    additionalSteps: [
        .generatePaginatedPages(),
        .step(named: "Tailwind", body: { step in
            try shellOut(
                to: "./tailwindcss",
                arguments: [
                    "-i",
                    "./Sources/Styles/global.css",
                    "-o",
                    "./Output/styles.css"
                ]
            )
        })
    ]
)
