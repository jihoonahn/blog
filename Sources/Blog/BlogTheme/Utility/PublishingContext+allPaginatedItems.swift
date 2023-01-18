import Publish

extension PublishingContext where Site == Blog {
    var paginatedItems: [[Item<Blog>]] {
        allItems(sortedBy: \.date, order: .descending).chunked(into: Constants.numberOfItemsPerIndexPage)
    }
}
