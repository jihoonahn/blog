import Foundation
import Plot
import Publish

struct IndexPosts: Component {
    var item: Item<Blog>
    var context: PublishingContext<Blog>
    
    var body: Component {
        Link(url: item.path.absoluteString) {
            Div {
                Div {
                    Div {
                        Image("/static/images/Blog/\(item.path.string).svg")
                    }.class("post-feed-image-inner")
                }.class("post-feed-image")
                Span {
                    Text(item.tags.map{ $0.string }.joined(separator: ", "))
                }.class("post-feed-tag")
                H4(item.title).class("post-feed-item-title")
                Paragraph(item.description).class("post-feed-item-description")
                Time(DateFormatter.blogTime.string(from: item.date))
                    .class("post-feed-item-time")
            }
        }.class("post-link")
    }
}
