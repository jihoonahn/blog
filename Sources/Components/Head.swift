extension Node where Context == HTML.DocumentContext {
    public static func head<W: Website>(for page: Location, context: PublishingContext<W>) -> Node {
        return .group(
            .head(
                .link(
                    .rel(.stylesheet),
                    .href("https://cdn.jsdelivr.net/npm/@docsearch/css@3")
                )
            ),
            .head(for: page, on: context.site, stylesheetPaths: [
                "styles.css"
            ])
        )
    }
}
