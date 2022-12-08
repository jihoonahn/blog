import Publish
import Plot
import Foundation

struct IndexPage: Component {
    let pageNumber: Int
    let items: [Item<Blog>]
    let context: PublishingContext<Blog>
    
    @ComponentBuilder
    var body: Component {
        ItemList(items: items, site: context.site, dateFormatter: .blog)
        PaginationList(
            numberOfPages: context.paginatedItems.count,
            activePage: pageNumber,
            pageURL: { context.index.paginatedPath(pageIndex: $0 - 1).absoluteString }
        )
    }
}
