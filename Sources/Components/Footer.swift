struct Footer: Component {
    let context: PublishingContext<Blog>

    var body: Component {
        Plot.Footer {
            Div {
                Div {
                    Div {
                        Paragraph {
                            Text("Copyright © ")
                            Link("Jihoonahn", url: "https://github.com/jihoonahn")
                                .class("text-stone-700")
                        }
                        .class("text-stone-600 my-0")
                    }
                    Div {
                        Paragraph {
                            Text("Made with Swift")
                        }
                        .class("text-stone-600 my-0")
                    }
                }
                .class("text-sm mx-3 my-auto p-2")
                Div {
                    List(context.site.socialMediaLinks) { socialMediaLink in
                        ListItem {
                            Link(url: socialMediaLink.url) {
                                Image(socialMediaLink.icon)
                                    .class("w-full h-auto rounded-none")
                            }
                        }
                        .class("text-center w-4 h-4")
                    }
                    .class("inline-flex gap-4 list-none")
                }
                .class("mx-2")
            }
            .class("flex flex-wrap justify-between p-1 mx-auto max-w-4xl")
        }
        .class("bg-blog-c-footer relative")
    }
}
