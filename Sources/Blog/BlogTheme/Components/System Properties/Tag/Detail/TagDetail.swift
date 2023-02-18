import Plot
import Publish

struct TagDetail: Component {
    let items: [Item<Blog>]
    let context: PublishingContext<Blog>
    let selectedTag: Tag?
    let pageNumber: Int
    
    var body: Component {
        SiteMain {
            Div {
                Div {
                    H2(selectedTag?.description ?? "Tag")
                    Paragraph("A collection of \(items.count) posts")
                }.class("tagDetail-title")
                Div {
                    if let selectedTag {
                        for item in context.paginatedItems(for: selectedTag)[pageNumber - 1] {
                            Posts(item: item, context: context)
                        }
                    }
                }.class("post-tagDetail-feed")
                if items.count > Constants.numberOfItemsPerTagsPage {
                    if let selectedTag {
                        Pagination(activePage: pageNumber, numberOfPages: context.paginatedItems(for: selectedTag).count, pageURL: { pageNumber in
                            context.site.paginatedPath(for: selectedTag, pageIndex: pageNumber - 1).absoluteString
                        })
                    }
                }
            }.class("inner")
        }
    }
}
