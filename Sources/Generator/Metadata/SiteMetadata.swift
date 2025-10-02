import Foundation

public struct SiteMetaData: Metadata {
    public let title: String
    public let description: String
    public let url: String
    public let favicon: Favicon

    public init(
        title: String = "jihoon.me",
        description: String = "This is a personal blog for iOS Developer jihoonahn.",
        url: String = "https://jihoon.me",
        favicon: Favicon = Favicon()
    ) {
        self.title = title
        self.description = description
        self.url = url
        self.favicon = favicon
    }
}
