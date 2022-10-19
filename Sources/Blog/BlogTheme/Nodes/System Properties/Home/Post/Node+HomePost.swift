import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func homePost(for item: Item<Blog>, on site: Blog) -> Node {
        return .article(
            .class("post-card"),
            .a(
                .class("post-card-image-link"),
                .div(
                    .class("post-card-image"),
                    .img(
                        .src("/images/Image/\(item.path.string).jpg")
                    )
                ),
                .href(item.path.absoluteString)
            ),
            .div(
                .class("post-card-content"),
                .a(
                    .class("post-card-content-link"),
                    .header(
                        .class("post-card-header"),
                        .span(
                            .class("post-card-tags"),
                            .text(item.tags.map{ $0.string }.joined(separator: ", "))
                        ),
                        .h2(
                            .class("post-card-title"),
                            .text(item.title)
                        )
                    ),
                    .section(
                        .class("post-card-excerpt"),
                        .p(
                            .text(item.description)
                        )
                    ),
                    .href(item.path.absoluteString)
                ),
                .footer(
                    .class("post-card-footer"),
                    .time(
                        .class("post-card-meta-date"),
                        .text(DateFormatter.blog.string(from: item.date))
                    )
                )
            )
        )
    }
}
