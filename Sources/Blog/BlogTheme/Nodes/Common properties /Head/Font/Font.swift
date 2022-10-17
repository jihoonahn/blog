import Plot

extension Node where Context == HTML.HeadContext {
    static func font_Link() -> Node {
        return .group(
            .link(
                .rel(.preconnect),
                .href("https://fonts.googleapis.com")
            ),
            .link(
                .rel(.preconnect),
                .href("https://fonts.gstatic.com"),
                .crossorigin()
            ),
            .link(
                .href("https://fonts.googleapis.com/css2?family=Open+Sans&display=swap"),
                .rel(.stylesheet)
            )
        )
    }
}
