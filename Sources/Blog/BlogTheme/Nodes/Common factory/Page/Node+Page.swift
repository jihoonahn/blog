import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func page(for site: Blog) -> Node {
        return .text("Hello")
    }
    
}
