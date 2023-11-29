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
                                .class("font-semibold text-gray-500 text-sm")
                        }
                    }
                    .class("component md:w-[654px]")
                    Div {
                        Div {
                            H1(item.title)
                                .class("m-0 leading-normal font-semibold text-heading-2 md:text-heading-1")
                        }
                    }
                    .class("component my-0 md:w-[654px]")
                    Div {
                        Div {
                            Text(item.description)
                        }
                        .class("text-lg md:text-2xl mx-auto")
                    }
                    .class("component mt-5 mb-0 md:w-[654px]")
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
                Div {
                    Div {
                        Div {
                            List(item.tags) { tag in
                                ListItem {
                                    Link(tag.string, url: context.site.url(for: tag))
                                        .class("block my-1 px-1.5 py-2 bg-neutral-900 text-white rounded-lg transition duration-200 ease-in-out hover:bg-zinc-300 hover:text-black")
                                }
                                .class("inline-block mr-1.5")
                            }
                            .class("m-0")
                        }
                        Button {
                            Image("/static/icons/copy.svg")
                                .class("my-0")
                        }
                        .accessibilityLabel("link share")
                        .class("copyPost m-1 w-9 h-9 p-1.5 bg-blog-c-button rounded-full hover:bg-gray-300 transition duration-200 ease-in-out")
                    }
                    .class("flex justify-between mt-6")
                }
                .class("mx-auto w-[85%] text-left mt-8 md:w-[700px]")
                PreviewPost(context: context, item: item)
                Script(.src("/static/scripts/post.js"))
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
