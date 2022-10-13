import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func posts(for items: [Item<Blog>], on site: Blog, title: String) -> Node {
        return .main(
            .class("site-main"),
            .section(
                .class("main-container"),
                .h1(.class("content-subhead"), .text(title)),
                .div(
                    .class("posts-item"),
                    .forEach(items) { item in
                        .postExcerpt(for: item, on: site)
                    }
                )
            )
        )
    }
}
