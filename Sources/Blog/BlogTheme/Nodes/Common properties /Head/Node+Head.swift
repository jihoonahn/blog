import Plot

extension Node where Context == HTML.DocumentContext {
    static func head(for site : Blog) -> Node {
        return Node.head(
            .title("\(site.name) - \(site.description)"),
            .meta(
                .charset(.utf8),
                .name("viewport"),
                .content("width=device-width, initial-scale=1")
            ),
            .icon_Link(),
            .script_Links(),
            .css_Links(),
            .font_Link()
        )
    }
}
