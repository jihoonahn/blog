struct TagListPage: Component {
    let tags: [Tag]
    let context: PublishingContext<Blog>

    var body: Component {
        PageLayout(title: "Tag") {
            Div {
                Paragraph("A collection of \(tags.count) tags.")
                    .class("text-gray-700")
                List(tags) { tag in
                    ListItem {
                        Link(tag.string, url: context.site.url(for: tag))
                            .class("p-2.5 border-2 bg-white border-stone-600 rounded-lg hover:bg-black text-black hover:text-white")
                    }
                    .class("inline-block mx-1 my-3")
                }
                .class("mx-0")
            }
        }
    }
}
