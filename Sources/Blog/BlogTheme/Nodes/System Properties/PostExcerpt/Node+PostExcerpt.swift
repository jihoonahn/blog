import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func postExcerpt(for item: Item<Blog>, on site: Blog) -> Node {
        return .article(
            .class("card"),
            .img(
                .class("card-Image"),
                .src(item.path)
            ),
            .article(
                .class("content"),
                .h3(
                    .text(item.title)
                ),
                .p(
                    .text(item.description)
                )
            )
        )
    }
}
