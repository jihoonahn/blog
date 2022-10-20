import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func tagDetail(for items: [Item<Blog>], on site: Blog, title: String) -> Node {
        return .main(
            .id("site-main"),
            .class("site-main outer"),
            .div(
                .class("inner"),
                .div(
                    .class("tagDetail-title"),
                    .h2(
                        .text(title)
                    ),
                    .p(
                        .text("A collection of \(items.count) posts")
                    )
                ),
                .div(
                    .class("post-tagDetail-feed"),
                    .forEach(items) { item in
                        .posts(for: item, on: site)
                    }
                )
            )
        )
    }
}
