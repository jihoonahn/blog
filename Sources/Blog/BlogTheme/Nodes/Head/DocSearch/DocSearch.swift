import Plot

extension Node where Context == HTML.HeadContext {
    static func docSearch() -> Node {
        return .link(
            .rel(.stylesheet),
            .href("https://cdn.jsdelivr.net/npm/@docsearch/css@3")
        )
    }
}
