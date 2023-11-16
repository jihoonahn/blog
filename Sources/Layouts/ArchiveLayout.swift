struct ArchiveLayout: Component {
    let title: String
    let items: [Item<Blog>]
    let context: PublishingContext<Blog>

    var body: Component {
        Div {
            H1(title)
                .class("text-heading-2 font-semibold")
            Section {
                List(items) { item in
                    Link(url: item.path.absoluteString) {
                        Figure {
                            Image(item.metadata.postImage)
                                .class("rounded-lg md:rounded-2xl p-0")
                        }
                        .class("my-auto self-start w-[130px] md:w-[265px]")
                        Div {
                            Paragraph(item.tags.map{ $0.string }.joined(separator: ","))
                                .class("text-blog-c-tag-text text-xs md:text-sm text-black m-0")
                            H3(item.title)
                                .class("text-black text-base md:text-heading-3 mb-2 mt-2")
                            Time(DateFormatter.time.string(from: item.date))
                                .class("text-sm md:text-base font-light text-blog-c-time-text")
                        }
                        .class("ml-3 md:ml-4 lg:ml-6")
                    }
                    .class("flex justify-start px-0 py-8 items-center border-t border-solid border-gray-300")
                }
                .class("m-0 list-none")
            }
            .class("border-b border-solid border-gray-300")
        }
        .class("px-4 sm:px-8 max-w-3xl mx-auto")
    }
}
