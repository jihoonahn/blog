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
                        H2("posts").class("post-title")
                        List(items) { item in
                            IndexPosts(item: item, context: context)
                        }.class("post-section-list")
                    }.class("post-section")
                    ASide {
                        IndexCategories(tags: context.allTags.reversed(), context: context)
                        IndexProfile(context: context)
                    }.class("post-sidebar")
                }.class("post-inner")
            }.class("inner")
        }
    }
}
