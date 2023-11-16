struct PostsLayout: Component {
    let items: [Item<Blog>]
    let context: PublishingContext<Blog>

    var body: Component {
        Div {
            List(items) { item in
                Article {
                    Link(url: item.path.absoluteString) {
                        Div {
                            Figure {
                                Image(item.metadata.postImage)
                                    .class("py-0 transition duration-300 ease-in-out group-hover:scale-105")
                            }
                            .class("h-full object-cover w-auto")
                        }
                        .class("block rounded-3xl overflow-hidden")
                        Div {
                            Paragraph(item.tags.map{ $0.string }.joined(separator: ", "))
                                .class("text-blog-c-tag-text text-xs md:text-sm my-1")
                            H3(item.title)
                                .class("text-heading-4 md:text-heading-3 font-semibold text-black my-3")
                            Time(DateFormatter.time.string(from: item.date))
                                .class("text-sm md:text-base font-light text-blog-c-time-text")
                        }
                        .class("p-4")
                    }
                    .class("group")
                }
            }
            .class("flex max-w-screen-md flex-col m-0 gap-y-4 list-none md:gap-y-6 lg:gap-y-8")
        }
        .class("flex flex-col items-center gap-20")
    }
}
