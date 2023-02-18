import Plot

extension Node where Context: HTMLSourceContext {
    static func type(_ type: String) -> Node {
        .attribute(named: "type",value: type)
    }
}
