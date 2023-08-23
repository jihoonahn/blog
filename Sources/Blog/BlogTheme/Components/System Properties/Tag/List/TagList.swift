import Plot
import Publish

struct TagList: Component {
    let tags: [Tag]
    let context: PublishingContext<Blog>

    var body: Component {
        SiteMain {
            Div {
                Div {
                    H2("Tag")
                    Paragraph("A collection of \(tags.count) Tags")
                }.class("tag-title")
                Div {
                    for tag in tags {
                        Link(tag.string, url: context.site.url(for: tag))
                            .class("tag-all-category")
                    }
                }.class("post-tags")
            }.class("inner")
        }
    }
}
