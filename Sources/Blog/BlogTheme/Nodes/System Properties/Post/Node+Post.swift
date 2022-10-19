import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func post(for item: Item<Blog>, on site: Blog) -> Node {
        return .article(
            .header(
                .class("site-post-head"),
                .div(
                    .class("site-post-head-image"),
                    .img(
                        .src("/images/Image/\(item.path.string).jpg")
                    )
                )
            ),
            .div(
                .class("site-post-head-title"),
                .h1(
                    .text(item.title)
                ),
                .section(
                    .class("site-post-full-meta"),
                    .time(
                        .text(DateFormatter.blog.string(from: item.date))
                    ),
                    .span(
                        .class("date-divider"),
                        .text("|")
                    ),
                    .forEach(item.tags) { tag in
                            .a(
                                .text("\(tag.string). "),
                                .href(site.path(for: tag))
                            )
                        
                    }
                )
            ),
            .div(
                .class("site-post-body"),
                .div(
                    .contentBody(item.body)
                )
            )
        )
    }
}
