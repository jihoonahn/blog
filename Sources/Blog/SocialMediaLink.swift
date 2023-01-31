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
            url: "https://github.com/JiHoonAHN",
            icon: "fa-brands fa-github"
        )
    }
    static var stackoverflow: SocialMediaLink {
        return SocialMediaLink(
            title: "Stack Overflow",
            url: "https://stackoverflow.com/users/20336807/jihoonahn",
            icon: "fa-brands fa-stack-overflow"
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
