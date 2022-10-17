import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func item(for item : Item<Blog>, on site: Blog) -> Node {
        return .post(for: item, on: site)
    }
}
