import Foundation
import Web

public struct RSSGenerator {
    private let posts: [Post]
    private let siteMetadata: Metadata
    
    public init(posts: [Post], siteMetadata: Metadata) {
        self.posts = posts
        self.siteMetadata = siteMetadata
    }
    
    public func generateRSS() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        var rssContent = """
        <?xml version="1.0" encoding="UTF-8"?>
        <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/">
        <channel>
            <title>\(siteMetadata.title)</title>
            <description>\(siteMetadata.description)</description>
            <link>\(siteMetadata.url)</link>
            <language>ko</language>
            <lastBuildDate>\(dateFormatter.string(from: Date()))</lastBuildDate>
            <atom:link href="\(siteMetadata.url)/feed.rss" rel="self" type="application/rss+xml"/>
            <ttl>60</ttl>
        """
        
        for post in posts {
            let postUrl = "\(siteMetadata.url)/posts/\(post.slug)"
            let description = post.metadata.description ?? String(post.content.prefix(200))
            
            rssContent += """
            
            <item>
                <title>\(post.metadata.title)</title>
                <link>\(postUrl)</link>
                <guid>\(postUrl)</guid>
                <pubDate>\(dateFormatter.string(from: post.metadata.date))</pubDate>
                <description>\(description)</description>
            """
            
            // 이미지가 있는 경우 추가
            if let image = post.metadata.image {
                rssContent += """
                <enclosure url="\(image)" type="image/jpeg"/>
                """
            }
            
            rssContent += """
            </item>
            """
        }
        
        rssContent += """
        
        </channel>
        </rss>
        """
        
        return rssContent
    }
}