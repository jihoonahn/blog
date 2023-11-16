extension Node where Context == HTML.DocumentContext {
    public static func head<W: Website>(for page: Location, context: PublishingContext<W>) -> Node {
        let site = context.site
        var title = page.title
        
        if title.isEmpty {
            title = site.name
        }

        var description = page.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: page)),
            .title(title),
            .description(description),
            .twitterCardType(page.imagePath == nil ? .summary : .summaryLargeImage),
            .link(
                .rel(.stylesheet),
                .href("https://cdn.jsdelivr.net/npm/@docsearch/css@3")
            ),
            .stylesheet("styles.css"),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(Path.defaultForRSSFeed, { path in
                let title = "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(page.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            })
        )
    }
}
