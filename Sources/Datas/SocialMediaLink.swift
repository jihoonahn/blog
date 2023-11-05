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
            icon: "fa-brands fa-linkedin-in"
        )
    }
    static var github: SocialMediaLink {
        SocialMediaLink(
            title: "GitHub",
            url: "https://github.com/Jihoonahn",
            icon: "fa-brands fa-github"
        )
    }
    static var rss: SocialMediaLink {
        SocialMediaLink(
            title: "Rss",
            url: "https://blog.jihoon.me/feed.rss",
            icon: "fa-solid fa-rss")
    }
    static var email: SocialMediaLink {
        SocialMediaLink(
            title: "Email",
            url: "mailto:jihoonahn.dev@gmail.com",
            icon: "fa-solid fa-envelope"
        )
    }
}
