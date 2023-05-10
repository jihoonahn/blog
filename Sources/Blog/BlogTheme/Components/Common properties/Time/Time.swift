import Plot

struct Time: Component {
    // MARK: - Properties
    var text: String
    
    // MARK: - Initalizer
    init(_ text: String) {
        self.text = text
    }
    
    var body: Component {
        Node<HTML.BodyContext>.nodeTime(.text(text))
    }
}
