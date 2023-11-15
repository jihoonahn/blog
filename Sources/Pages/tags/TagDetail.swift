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
            }
        }
    }
}
