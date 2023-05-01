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
                        Image(item.metadata.postImage)
                    }.class("post-image-inner")
                }.class("post-image")
                Span {
                    Text(item.tags.map{ $0.string }.joined(separator: ", "))
                }.class("post-feed-tag")
                H4(item.title).class("post-item-title")
                Paragraph(item.description).class("post-item-description")
                Time(DateFormatter.blogTime.string(from: item.date)).class("post-item-time")
            }
        }.class("post-link")
    }
}
