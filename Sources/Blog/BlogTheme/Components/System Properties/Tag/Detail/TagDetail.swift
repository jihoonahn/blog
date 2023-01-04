import Plot
import Publish

struct TagDetail: Component {
    var items: [Item<Blog>]
    var context: PublishingContext<Blog>
    var title: String
    
    var body: Component {
        SiteMain {
            Div {
                Div {
                    H2(title)
                    Paragraph("A collection of \(items.count) posts")
                }.class("tagDetail-title")
                Div {
                    for item in items {
                        Posts(item: item, context: context)
                    }
                }.class("post-tagDetail-feed")
            }.class("inner")
        }
    }
}
