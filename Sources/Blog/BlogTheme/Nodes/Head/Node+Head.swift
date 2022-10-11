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
            .script(
                .src("https://kit.fontawesome.com/662f6d0c39.js"),
                .crossorigin("anonymous")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/style.css")
            ),
            .link(
                .href("https: //fonts.googleapis.com/css2? family= Open+Sans & display=swap"),
                .rel(.stylesheet)
            )
        )
    }
}
