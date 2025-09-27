import Foundation

public struct BlogConfig: Codable, Equatable, Sendable {
    public let id: UUID
    public let siteName: String
    public let siteDescription: String
    public let siteUrl: String
    public let adminEmail: String
    public let postsPerPage: Int
    public let allowComments: Bool
    public let moderateComments: Bool
    public let allowRegistration: Bool
    public let theme: String
    public let language: String
    public let timezone: String
    public let dateFormat: String
    public let socialLinks: [String: String]
    public let seoTitle: String?
    public let seoDescription: String?
    public let seoKeywords: [String]
    public let analyticsId: String?
    public let createdAt: Date
    public let updatedAt: Date
    
    public init(
        id: UUID = UUID(),
        siteName: String = "My Blog",
        siteDescription: String = "개인 블로그입니다",
        siteUrl: String = "",
        adminEmail: String = "",
        postsPerPage: Int = 10,
        allowComments: Bool = true,
        moderateComments: Bool = true,
        allowRegistration: Bool = false,
        theme: String = "default",
        language: String = "ko",
        timezone: String = "Asia/Seoul",
        dateFormat: String = "yyyy년 MM월 dd일",
        socialLinks: [String: String] = [:],
        seoTitle: String? = nil,
        seoDescription: String? = nil,
        seoKeywords: [String] = [],
        analyticsId: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.siteName = siteName
        self.siteDescription = siteDescription
        self.siteUrl = siteUrl
        self.adminEmail = adminEmail
        self.postsPerPage = postsPerPage
        self.allowComments = allowComments
        self.moderateComments = moderateComments
        self.allowRegistration = allowRegistration
        self.theme = theme
        self.language = language
        self.timezone = timezone
        self.dateFormat = dateFormat
        self.socialLinks = socialLinks
        self.seoTitle = seoTitle
        self.seoDescription = seoDescription
        self.seoKeywords = seoKeywords
        self.analyticsId = analyticsId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
