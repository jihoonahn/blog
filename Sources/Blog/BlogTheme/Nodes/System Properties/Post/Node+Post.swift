import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    
    static func post(for item: Item<Blog>, on site: Blog) -> Node {
        return .article(
            .header(
                .class("post-header"),
                .div(
                    .class("post-header-div"),
                    .div(
                        .class("post-header-img"),
                        .img(
                            .src("/images/Image/\(item.path.string).jpg")
                        )
                    ),
                    .div(
                        .class("post-header-title"),
                        .h1(
                            .text(item.title)
                        ),
                        .p(
                            .text(DateFormatter.blog.string(from: item.date))
                        ),
                        .tagList(for: item.tags, on: site)
                    )
                )
            ),
            .div(
                .class("post-body"),
                .div(
                    .contentBody(item.body)
                )
            )
        )
    }
}
