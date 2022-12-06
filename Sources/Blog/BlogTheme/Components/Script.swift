import Plot

struct Script: Component {
    // MARK: - Properties
    var url: URLRepresentable
    
    // MARK: - Initalizer
    init(url: URLRepresentable) {
        self.url = url
    }
    
    var body: Component {
        Node<HTML.BodyContext>.script(.src(url))
    }
}
