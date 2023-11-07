struct IndexPage: Component {
    let pageNumber: Int
    let context: PublishingContext<Blog>
    
    var body: Component {
        Div {
            Section {
                PostsLayout(item: context.paginatedItems[pageNumber-1], context: context)
                Pagination(activePage: pageNumber, numberOfPages: context.paginatedItems.count) { num in
                    context.index.paginatedPath(pageIndex: pageNumber-1).absoluteString
                }
            }
            .class("")
        }
        .class("bg-red font-serif leading-normal tracking-normal")
    }
}
