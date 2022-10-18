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
                .href("/theme/footer/footer_style.css")
            )
        )
    }
}
