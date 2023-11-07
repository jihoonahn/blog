struct BlogHTMLFactory: HTMLFactory {
    typealias Site = Blog
    
    @HTMLBuilder 
    func makeIndexHTML(
        for index: Publish.Index,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML {
        BaseLayout(for: index, context: context) {
            IndexPage(pageNumber: 1, context: context)
        }
    }
    
    @HTMLBuilder 
    func makeSectionHTML(
        for section: Publish.Section<Blog>,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML {
        BaseLayout(for: section, context: context) {
            SectionPage(section: section, context: context)
        }
    }
    
    @HTMLBuilder 
    func makeItemHTML(
        for item: Publish.Item<Blog>,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML {
        BaseLayout(for: item, context: context) {
            PostPage(item: item, context: context)
        }
    }
    
    @HTMLBuilder 
    func makePageHTML(
        for page: Publish.Page,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML {
        BaseLayout(for: page, context: context) {
            PagePage(page: page, context: context)
        }
    }
    
    @HTMLBuilder 
    func makeTagListHTML(
        for page: Publish.TagListPage,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML? {
        BaseLayout(for: page, context: context) {
            TagListPage(tags: page.tags.reversed(), context: context)
        }
    }
    
    @HTMLBuilder 
    func makeTagDetailsHTML(
        for page: Publish.TagDetailsPage,
        context: Publish.PublishingContext<Blog>
    ) throws -> HTML? {
        BaseLayout(for: page, context: context) {
            TagDetailPage(
                items: context.items(
                    taggedWith: page.tag,
                    sortedBy: \.date
                ),
                context: context,
                selectedTag: page.tag,
                pageNumber: 1
            )
        }
    }
}
