import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func section(for site: Blog) -> Node {
        return .text("Hello")
    }
    
}
