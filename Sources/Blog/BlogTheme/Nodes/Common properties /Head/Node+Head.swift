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
                .src("/js/main.js"),
                .defer()
            ),
            .script(
                .src("https://kit.fontawesome.com/662f6d0c39.js"),
                .crossorigin("anonymous")
            ),
            //MARK: - icon
            .link(
                .rel(.icon),
                .type("image/x-icon"),
                .href("/images/Icon/icon.svg")
            ),
            //MARK: - css connect
            .link(
                .rel(.stylesheet),
                .href("/theme/default/default_style.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/Header/HomeHeader.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/Header/Basic/HeaderStyle.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/Header/Header.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/Tag/Tag.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/Post/Post.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/Footer/Footer.css")
            ),
            //MARK: - google font
            .link(
                .href("https: //fonts.googleapis.com/css2? family= Open+Sans & display=swap"),
                .rel(.stylesheet)
            )
        )
    }
}
