import Foundation
import Plot
import Publish

struct Posts: Component {
    
    var item: Item<Blog>
    var context: PublishingContext<Blog>
    
    var body: Component {
        Article {
            Link(url: item.path.absoluteString) {
                Div {
                    Image("/static/images/Blog/\(item.path.string).svg")
                }.class("post-article-image")
                Div {
                    Span {
                        Text(item.tags.map{ $0.string }.joined(separator: ", "))
                    }.class("post-feed-tag")
                    H3(item.title).class("post-article-content-title")
                    Paragraph(item.description).class("post-article-content-description")
                    Time(DateFormatter.blogTime.string(from: item.date)).class("post-article-content-time")
                }.class("post-article-content")
            }.class("post-article-link")
        }.class("post-article")
    }
}
