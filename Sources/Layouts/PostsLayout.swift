struct PostsLayout: Component {
    let item: [Item<Blog>]
    let context: PublishingContext<Blog>

    var body: Component {
        Div {
            List(item) { item in
                Article {
                    Link(url: item.path.absoluteString) {
                        Div {
                            Image(item.metadata.postImage)
                                .class("w-full h-auto")
                        }
                        .class("rounded-2xl overflow-hidden transition-transform transform-gpu group-hover:scale-[1.03]")
                        Div {
                            Paragraph(item.tags.map{ $0.string }.joined(separator: ", "))
                                .class("text-blog-c-tag-text text-xs my-1")
                            H3(item.title)
                                .class("text-heading-3 font-semibold my-3")
                            Time(DateFormatter.time.string(from: item.date))
                                .class("text-base font-light text-blog-c-time-text")
                        }
                        .class("p-4")
                    }
                    .class("group")
                }
            }
            .class("flex max-w-screen-md flex-col gap-y-4 md:gap-y-6 lg:gap-y-8")
        }
        .class("flex flex-col items-center gap-20 pt-20")
    }
}
