import Foundation

struct SocialMediaLink {
    let title: String
    let url: String
    let icon: String
}

extension SocialMediaLink {
    static var linkedIn: SocialMediaLink {
        SocialMediaLink(
            title: "LinkedIn",
            url: "https://www.linkedin.com/in/ahnjihoon/",
            icon: "/static/icons/linkedin.svg"
        )
    }
    static var github: SocialMediaLink {
        SocialMediaLink(
            title: "GitHub",
            url: "https://github.com/jihoonahn",
            icon: "/static/icons/github.svg"
        )
    }
    static var rss: SocialMediaLink {
        SocialMediaLink(
            title: "Rss",
            url: "https://blog.jihoon.me/feed.rss",
            icon: "/static/icons/rss-solid.svg")
    }
    static var email: SocialMediaLink {
        SocialMediaLink(
            title: "Email",
            url: "mailto:jihoonahn.dev@gmail.com",
            icon: "/static/icons/envelope-solid.svg"
        )
    }
}
