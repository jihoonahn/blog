import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func item(for site: Blog) -> Node {
        return .text("Hello")
    }
    
}
