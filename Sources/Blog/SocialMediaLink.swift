import Foundation

struct SocialMediaLink {
    let title: String
    let url: String
    let icon: String
}

extension SocialMediaLink {
    static var github: SocialMediaLink {
        return SocialMediaLink(
            title: "GitHub",
            url: "https://github.com/JiHoonAHN",
            icon: "fab fa-github-square"
        )
    }
    static var email: SocialMediaLink {
        return SocialMediaLink(
            title: "Email",
            url: "mailto:official@jihoon.me",
            icon: "fas fa-envelope-open-text"
        )
    }
}
