struct IndexPage: Component {
    let pageNumber: Int
    let context: PublishingContext<Blog>
    
    var body: Component {
        Div {
            Section {
                PostsLayout(item: context.paginatedItems[pageNumber-1], context: context)
                Pagination(activePage: pageNumber, numberOfPages: context.paginatedItems.count) { num in
                    context.index.paginatedPath(pageIndex: num - 1).absoluteString
                }
            }
            .class("mx-auto w-full px-6 lg:px-0")
        }
        .class("flex lg:flex-row flex-col-reverse")
    }
}
