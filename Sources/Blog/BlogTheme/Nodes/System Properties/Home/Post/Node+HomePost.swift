import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func homePost(for item: Item<Blog>, on site: Blog) -> Node {
        return .article(
            .class("post-card home-template"),
            .a(
                .class("post-card-image-link"),
                .img(
                    .class("post-card-image"),
                    .src("/images/Image/\(item.path.string).svg")
                )
            ),
            .div(
                .class("post-card-content"),
                .a(
                    .class("post-card-content-link"),
                    .header(
                        .class("post-card-header")
                    ),
                    .section(
                        .class("post-card-excerpt")
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
        )
    }
}
