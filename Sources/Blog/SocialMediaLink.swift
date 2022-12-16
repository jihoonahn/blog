import Foundation

struct SocialMediaLink {
    let title: String
    let url: String
    let icon: String
}

extension SocialMediaLink {
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
            url: "https://github.com/JiHoonAHN",
            icon: "fa-brands fa-github"
        )
    }
    static var email: SocialMediaLink {
        return SocialMediaLink(
            title: "Email",
            url: "mailto:official@jihoon.me",
            icon: "fa-solid fa-envelope"
        )
    }
}
