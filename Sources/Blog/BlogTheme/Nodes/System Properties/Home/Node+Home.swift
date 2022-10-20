import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func homePage(for items: [Item<Blog>],on site: Blog) -> Node {
        return .main(
            .id("site-main"),
            .class("site-main outer"),
            .div(
                .class("inner"),
                .div(
                    .class("post-feed"),
                    .forEach(items) { item in
                        .posts(for: item, on: site)
                    }
                )
            )
        )
    }
}
