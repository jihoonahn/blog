import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func posts(for items: [Item<Blog>], on site: Blog, context: PublishingContext<Blog>) -> Node {
        return .main(
            .section(
                .class("main-container"),
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
