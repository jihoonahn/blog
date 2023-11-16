struct TagDetailPage: Component {
    let items: [Item<Blog>]
    let context: PublishingContext<Blog>
    let selectedTag: Tag?
    let pageNumber: Int

    var body: Component {
        Section {
            Div {
                ArchiveLayout(
                    title: selectedTag?.string ?? "Tag Archive",
                    items: items,
                    context: context
                )
                if items.count > Constants.numberOfItemsPerTagsPage || pageNumber > 1 {
                    if let selectedTag {
                        Pagination(activePage: pageNumber, numberOfPages: context.paginatedItems(for: selectedTag).count) { num in
                            context.site.paginatedPath(for: selectedTag, pageIndex: num - 1).absoluteString
                        }
                    }
                }
            }
        }
    }
}
