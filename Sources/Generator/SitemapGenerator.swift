import Foundation
import Web

public struct SitemapGenerator {
    private let pages: [Page]
    private let posts: [Post]
    private let siteMetadata: SiteMetaData
    
    public init(pages: [Page], posts: [Post], siteMetadata: SiteMetaData) {
        self.pages = pages
        self.posts = posts
        self.siteMetadata = siteMetadata
    }
    
    public func generateSitemap() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var sitemapContent = """
        <?xml version="1.0" encoding="UTF-8"?>
        <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
        """
        
        // 정적 페이지들 추가
        for page in pages {
            let url = "\(siteMetadata.url)/\(page.path.replacingOccurrences(of: "index.html", with: ""))"
            let cleanUrl = url.hasSuffix("/") ? String(url.dropLast()) : url
            let finalUrl = cleanUrl.isEmpty ? siteMetadata.url : cleanUrl
            
            sitemapContent += """
            
            <url>
                <loc>\(finalUrl)</loc>
                <lastmod>\(dateFormatter.string(from: Date()))</lastmod>
                <changefreq>weekly</changefreq>
                <priority>0.8</priority>
            </url>
            """
        }
        
        // 블로그 포스트들 추가
        for post in posts {
            let postUrl = "\(siteMetadata.url)/posts/\(post.slug)"
            let lastmod = dateFormatter.string(from: post.metadata.date)
            
            sitemapContent += """
            
            <url>
                <loc>\(postUrl)</loc>
                <lastmod>\(lastmod)</lastmod>
                <changefreq>monthly</changefreq>
                <priority>0.9</priority>
            </url>
            """
        }
        
        sitemapContent += """
        
        </urlset>
        """
        
        return sitemapContent
    }
}
