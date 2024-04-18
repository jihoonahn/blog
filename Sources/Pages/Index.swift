struct IndexPage: Component {
    let pageNumber: Int
    let context: PublishingContext<Blog>

    var body: Component {
        Section  {
            PostsLayout(items: context.paginatedItems[pageNumber-1], context: context)
            Pagination(activePage: pageNumber, numberOfPages: context.paginatedItems.count) { num in
                context.index.paginatedPath(pageIndex: num - 1).absoluteString
            }
        }
        .class("px-4 sm:px-8 max-w-3xl mx-auto")
    }
}
