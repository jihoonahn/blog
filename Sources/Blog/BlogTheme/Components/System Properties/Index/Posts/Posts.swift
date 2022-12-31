import Foundation
import Plot
import Publish

struct Posts: Component {
    
    var item: Item<Blog>
    var context: PublishingContext<Blog>

    var body: Component {
        Article {
            Link(url: item.path.absoluteString) {
                Div()
                    .class("post-card-image")
                    .style("background-image: url(/static/images/Post/\(item.path.string).svg)")
            }.class("post-card-image-link")
            Div {
                Link(url: item.path.absoluteString) {
                    Header {
                        Span {
                            Text(item.tags.map{ $0.string }.joined(separator: ". "))
                        }.class("post-card-tags")
                        H2(item.title)
                            .class("post-card-title")
                    }.class("post-card-header")
                    Section {
                        Paragraph(item.description)
                    }.class("post-card-excerpt")
                }.class("post-card-content-link")
                Footer {
                    Time(DateFormatter.blogTime.string(from: item.date))
                        .class("post-card-meta-date")
                }.class("post-card-footer")
            }.class("post-card-content")
        }.class("post-card home-template")
    }
}


