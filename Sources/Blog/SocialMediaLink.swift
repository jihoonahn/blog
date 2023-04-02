import Foundation

struct SocialMediaLink {
    let title: String
    let url: String
    let icon: String
}

extension SocialMediaLink {
    static var linkedIn: SocialMediaLink {
        return SocialMediaLink(
            title: "LinkedIn",
            url: "https://www.linkedin.com/in/ahnjihoon/",
            icon: "fa-brands fa-linkedin-in"
        )
    }
    static var twitter: SocialMediaLink {
        return SocialMediaLink(
            title: "Twitter",
            url: "https://twitter.com/jihoon_dev",
            icon: "fa-brands fa-twitter"
        )
    }
    static var github: SocialMediaLink {
        return SocialMediaLink(
            title: "GitHub",
            url: "https://github.com/Jihoonahn",
            icon: "fa-brands fa-github"
        )
    }
    static var rss: SocialMediaLink {
        return SocialMediaLink(
            title: "Rss",
            url: "https://blog.jihoon.me/feed.rss",
            icon: "fa-solid fa-rss")
    }
    static var email: SocialMediaLink {
        return SocialMediaLink(
            title: "Email",
            url: "mailto:official@jihoon.me",
            icon: "fa-solid fa-envelope"
        )
    }
}
