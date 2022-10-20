import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func tagList(for tags: [Tag], on site: Blog) -> Node {
        return .main(
            .id("site-main"),
            .class("site-main outer"),
            .div(
                .class("inner"),
                .div(
                    .class("tag-title"),
                    .h2(
                        .text("Tag")
                    ),
                    .p(
                        .text("A collection of \(tags.count) Tags")
                    )
                ),
                .div(
                    .class("post-tags"),
                    .forEach(tags) { tag in
                            .a(
                                .class("tag-all-category"),
                                .href(site.path(for: tag)),
                                .text(tag.string)
                            )
                    }
                )
            )
        )
    }
    
    static func tagList(for item: Item<Blog>, on site: Blog) -> Node {
        return .tagList(for: item.tags, on: site)
    }
    
    static func tagList(for page: TagListPage, on site: Blog) -> Node {
        return .tagList(for: Array(page.tags), on: site)
    }
}
