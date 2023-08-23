import Plot
import Publish

struct IndexPage: Component {
    let pageNumber: Int
    let context: PublishingContext<Blog>

    var body: Component {
        SiteMain {
            Div {
                Div {
                    Section {
                        H2("posts").class("post-title")
                        List(context.paginatedItems[pageNumber - 1]) { item in
                            IndexPosts(item: item, context: context)
                        }.class("post-section-list")
                    }.class("post-section")
                    ASide {
                        IndexCategories(tags: context.allTags.reversed(), context: context)
                        IndexProfile(context: context)
                    }.class("post-sidebar")
                }.class("post-inner")
                if context.allTags.count > Constants.numberOfItemsPerIndexPage {
                    Pagination(activePage: pageNumber, numberOfPages: context.paginatedItems.count, pageURL: { pageNumber in
                        context.index.paginatedPath(pageIndex: pageNumber - 1).absoluteString
                    })
                }
            }.class("inner")
        }
    }
}
