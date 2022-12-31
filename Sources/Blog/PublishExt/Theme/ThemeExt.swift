import Plot

extension Node where Context: HTMLSourceContext {
    static func theme(_ text: String) -> Node {
        .attribute(named: "theme",value: text)
    }
}
