import Plot

extension Node where Context == HTML.HeadContext {
    static func icon_Link() -> Node {
        return .link(
            .rel(.icon),
            .type("image/x-icon"),
            .href("/images/Icon/icon.svg")
        )
    }
}
