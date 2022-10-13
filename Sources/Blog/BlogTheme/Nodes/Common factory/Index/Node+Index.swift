import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func index(for items: [Item<Blog>], on site: Blog, title: String) -> Node {
        return .posts(for: items, on: site, title: title)
    }
}
