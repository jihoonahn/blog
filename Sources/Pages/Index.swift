struct IndexPage: Component {
    let pageNumber: Int
    let context: PublishingContext<Blog>

    var body: Component {
        PageLayout(title: "Posts") {
            ComponentGroup {
                PostsLayout(items: context.paginatedItems[pageNumber-1], context: context)
                Pagination(activePage: pageNumber, numberOfPages: context.paginatedItems.count) { num in
                    context.index.paginatedPath(pageIndex: num - 1).absoluteString
                }
            }
        }
    }
}
