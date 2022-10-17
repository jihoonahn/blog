import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func postExcerpt(for item: Item<Blog>, on site: Blog) -> Node {
        return .article(
            .class("card"),
            .a(
                .img(
                    .class("card-Image"),
                    .src("/images/Image/\(item.path).jpg")
                ),
                .div(
                    .class("content"),
                    .p(.class("post-tags post-category"),
                       .text(item.tags.map{ $0.string }.joined(separator: ", "))
                    ),
                    .h3(
                        .class("card-item-title"),
                        .text(item.title)
                    ),
                    .p(
                        .class("card-item-date"),
                        .text(DateFormatter.blog.string(from: item.date))
                    ),
                    .p(
                        .class("card-item-description"),
                        .text(item.description)
                    )
                ),
                .href(item.path)
            )
        )
    }
}
