import Web
import File
import Generator

extension Node where Context == HTML.DocumentContext {
    static func head(site: SiteMetaData) -> Node {
        let title = site.title
        let description = site.description
        let url = site.url

        return .head(
            .encoding(.utf8),
            .siteName(title),
            .url(url),
            .title(title),
            .description(description),
            .twitterCardType(.summaryLargeImage),
            .link(
                .rel(.stylesheet),
                .href("https://cdn.jsdelivr.net/npm/@docsearch/css@4")
            ),
            .stylesheet("/global.css"),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap("/feed.rss", { path in
                let title = "Subscribe to \(site.title)"
                return .rssFeedLink(Path(path).absolutePath.rawValue, title: title)
            })

        )
    }
}
