import Plot

struct Script: Component {
    // MARK: - Properties
    var nodes: [Node<HTML.ScriptContext>]

    // MARK: - Initalizer
    init(_ nodes: Node<HTML.ScriptContext>...) {
        self.nodes = nodes
    }

    var body: Component {
        Node<HTML.BodyContext>.script(nodes.node)
    }
}
