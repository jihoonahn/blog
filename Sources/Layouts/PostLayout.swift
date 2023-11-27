struct PostLayout: Component {
    var item: Item<Blog>
    var context: PublishingContext<Blog>

    var body: Component {
        Section {
            Article {
                Div {
                    Div {
                        Div {
                            Time(DateFormatter.time.string(from: item.date))
                                .class("text-gray-500 text-sm")
                        }
                    }
                    .class("component md:w-[654px]")
                    Div {
                        Div {
                            H1(item.title)
                                .class("m-0 leading-normal font-semibold text-heading-2 md:text-heading-1")
                        }
                    }
                    .class("component md:w-[654px]")
                    Div {
                        Div {
                            Text(item.description)
                        }
                        .class("text-lg md:text-2xl mx-auto")
                    }
                    .class("component md:w-[654px]")
                }
                Figure {
                    Div {
                        Image(item.metadata.postImage)
                            .class("my-0")
                    }
                }
                .class("component rounded-xl border border-gray-200 overflow-hidden min-w-[85%] lg:min-w-[320px]")
                Div {
                    Div {
                        Node.contentBody(item.body)
                    }
                }
                .class("mx-auto w-[85%] text-left mt-8 md:w-[700px]")
                PreviewPost(context: context, item: item)
                Script(
                    .src("https://utteranc.es/client.js"),
                    .repo("jihoonahn/blog"),
                    .issue_term("pathname"),
                    .label("comments"),
                    .theme("github-light"),
                    .crossorigin("anonymous"),
                    .async()
                )
            }
        }
    }
}
