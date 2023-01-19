import Plot

extension Node where Context: HTMLSourceContext {
    static func repo(_ text: String) -> Node {
        .attribute(named: "repo",value: text)
    }
}
