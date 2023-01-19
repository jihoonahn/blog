import Plot

extension Node where Context == HTML.HeadContext {
    static func fontAwesome() -> Node {
        return .script(
            .src("https://kit.fontawesome.com/662f6d0c39.js"),
            .crossorigin("anonymous")
        )
    }
}
