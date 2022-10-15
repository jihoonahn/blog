import Plot

extension Node where Context == HTML.BodyContext {
    static func grid(_ nodes: Node...) -> Node {
        .div(
            .class("wrapper"),
            .group(nodes)
        )
    }
}
