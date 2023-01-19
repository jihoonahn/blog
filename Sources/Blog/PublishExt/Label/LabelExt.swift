import Plot

extension Node where Context: HTMLSourceContext {
    static func label(_ text: String) -> Node {
        .attribute(named: "label",value: text)
    }
}
