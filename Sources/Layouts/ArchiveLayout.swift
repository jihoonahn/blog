struct ArchiveLayout: Component {
    let title: String
    let items: [Item<Blog>]
    let context: PublishingContext<Blog>

    var body: Component {
        Div {
            H1(title)
                .class("text-heading-2 font-semibold")
            Section {
                Div {
                    List(items) { item in
                        Link(url: item.path.absoluteString) {
                            Figure {
                                Image(item.metadata.postImage)
                            }
                            Div {
                                Paragraph(item.tags.map{ $0.string }.joined(separator: ","))
                                H3(item.title)
                                Time(DateFormatter.time.string(from: item.date))
                            }
                        }
                    }
                }
            }
        }
        .class("px-4 sm:px-8 max-w-3xl mx-auto")
    }
}
