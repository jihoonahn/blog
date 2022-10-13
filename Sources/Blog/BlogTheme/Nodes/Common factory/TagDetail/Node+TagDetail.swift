import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func tagDetail(for site: Blog) -> Node {
        return .text("Hello")
    }
    
}
