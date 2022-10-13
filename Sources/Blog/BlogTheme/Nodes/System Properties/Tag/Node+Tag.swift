import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func tagList(for tags: [Tag], on site: Blog) -> Node {
        return .div(
            .class("post-tags"),
            .forEach(tags, { tag in
                    .a(
                        .class("post-category post-category-\(tag.string.lowercased())"),
                        .href(site.path(for: tag)),
                        .text(tag.string)
                    )
            })
        )
    }
    
    static func tagList(for item: Item<Blog>, on site: Blog) -> Node {
        return .tagList(for: item.tags, on: site)
    }
}
