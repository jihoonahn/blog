struct ArchiveLayout: Component {
    let items: [Item<Blog>]
    let context: PublishingContext<Blog>

    var body: Component {
        Div {
            List(items) { item in
                Link(url: item.path.absoluteString) {
                    Figure {
                        Image(item.metadata.postImage)
                            .class("m-0")
                    }
                    .class("my-auto border border-gray-200 rounded-lg md:rounded-2xl overflow-hidden self-start w-[30%] md:w-[350px]")
                    Div {
                        Paragraph(item.tags.map{ $0.string }.joined(separator: ","))
                            .class("text-blog-c-tag-text text-xs md:text-sm text-black m-0 break-all")
                        H3(item.title)
                            .class("text-black text-base md:text-heading-3 mb-2 mt-2 break-all")
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
}
