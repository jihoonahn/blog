import Plot
import Publish

struct IndexPage: Component {
    var context: PublishingContext<Blog>
    var items: [Item<Blog>]
    
    @ComponentBuilder
    var body: Component {
        SiteMain {
            Div {
                Div {
                    Section {
                        H2("Blog").class("post-feed-title")
                        List(items) { item in
                            IndexPosts(item: item, context: context)
                        }.class("post-feed-list")
                    }.class("post-feed")
                }.class("post-inner")
            }.class("inner")
        }
    }
}
