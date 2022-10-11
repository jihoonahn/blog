import Plot

extension Node where Context: HTMLSourceContext {
    static func crossorigin(_ text: String) -> Node {
        .attribute(named: "crossorigin",value: text)
    }
}
