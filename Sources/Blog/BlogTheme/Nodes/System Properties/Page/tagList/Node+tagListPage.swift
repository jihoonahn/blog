import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    
    static func tagListPage(for page: TagListPage, context: PublishingContext<Blog>) -> Node {
        return .article(
            .class("tagList-style"),
            .h1(
                .text("Tag")
            ),
            .p(
                .text("All the tags that make up the project.")
            ),
            .div(
                .class("tagList-tag"),
                .tagList(for: page.tags.reversed(), on: context.site)
            )
        )
    }
    
}
