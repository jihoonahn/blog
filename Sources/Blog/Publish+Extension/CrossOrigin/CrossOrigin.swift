import Plot

extension Node where Context: HTMLSourceContext {
    static func crossorigin(_ text: String) -> Node {
        .attribute(named: "crossorigin",value: text)
    }
}

extension Attribute where Context : HTMLLinkableContext {
    static func crossorigin(_ text: String? = "") -> Attribute {
        Attribute(name: "crossorigin", value: text)
    }
}
