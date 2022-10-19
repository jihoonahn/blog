import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func tagDetail(for items: [Item<Blog>], on site: Blog, title: String) -> Node {
        return .div(
            .class("site-tagDetail-content"),
            .h1(
                .class("site-tagDetail-title"),
                .text(title)
            ),
            .h1(
                .class("site-tagDetail-title"),
                .text(title)
            ),
            .h1(
                .class("site-tagDetail-title"),
                .text(title)
            ),
            .h1(
                .class("site-tagDetail-title"),
                .text(title)
            )
        )
    }
}
