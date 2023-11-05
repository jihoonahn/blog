import Plot
import Publish
import Foundation

struct BlogHTMLFactory: HTMLFactory {
    typealias Site = Blog
    
    @HTMLBuilder func makeIndexHTML(
        for index: Publish.Index,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML {
        Base(for: index, context: context) {
            H1("Hello")
        }
    }
    
    @HTMLBuilder func makeSectionHTML(
        for section: Publish.Section<Blog>,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML {
        HTML()
    }
    
    @HTMLBuilder func makeItemHTML(
        for item: Publish.Item<Blog>,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .body {}
        )
    }
    
    @HTMLBuilder func makePageHTML(
        for page: Publish.Page,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .body {}
        )
    }
    
    @HTMLBuilder func makeTagListHTML(
        for page: Publish.TagListPage,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .body {}
        )
    }
    
    @HTMLBuilder func makeTagDetailsHTML(
        for page: Publish.TagDetailsPage,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .body {}
        )
    }
}
