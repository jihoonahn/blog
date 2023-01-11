import Plot
import Publish

struct IndexCategories: Component {
    var tags: [Tag]
    var context: PublishingContext<Blog>
    
    var body: Component {
        Div {
            H2("Explore Categories")
                .class("post-title")
            Div {
                for tag in tags {
                    Link(tag.string, url: context.site.url(for: tag))
                        .class("tag-all-category")
                }
            }.class("post-tags")
        }
    }
}
