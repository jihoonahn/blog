import Plot

extension Node where Context == HTML.DocumentContext {
    static func head(for site : Blog, title: String? = nil, description: String? = nil) -> Node {
        return Node.head(
            .meta(
                .charset(.utf8),
                .name("viewport"),
                .content("width=device-width, initial-scale=1")
            ),
            .seo(for: site, title: title, description: description),
            .icon_Link(),
            .script_Links(),
            .css_Links(),
            .font_Link()
        )
    }
}
