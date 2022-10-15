import Plot

extension Node where Context == HTML.HeadContext {
    static func css_Links() -> Node {
        return .group(
            .link(
                .rel(.stylesheet),
                .href("/theme/default/default_style.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/Header/Header.css")
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
            .link(
                .rel(.stylesheet),
                .href("/theme/Page/DefaultPage/Page.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/Page/AboutPage/Page.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/Page/TagListPage/Page.css")
            )
        )
    }
}
