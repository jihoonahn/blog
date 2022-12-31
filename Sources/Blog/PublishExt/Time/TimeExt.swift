import Plot

extension Node where Context == HTML.BodyContext {
    static func time(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "time", nodes: nodes)
    }
}
