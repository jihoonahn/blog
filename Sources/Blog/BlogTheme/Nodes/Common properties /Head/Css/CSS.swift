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
                .href("/theme/header/header_style.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/footer/footer_style.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/home/home_style.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/post/post_style.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/tagDetail/tagDetail_style.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/page/debate/debate_style.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/theme/page/about/about_style.css")
            )
        )
    }
}
