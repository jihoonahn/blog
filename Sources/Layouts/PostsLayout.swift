struct PostsLayout: Component {
    let item: [Item<Blog>]
    let context: PublishingContext<Blog>

    var body: Component {
        Div {
            List(item) { item in
                Article {
                    Link(url: item.path.absoluteString) {
                        Plot.Header {
                            Paragraph(item.tags.map{ $0.string }.joined(separator: ", "))
                                .class("posts-tags")
                        }
                        Image(item.metadata.postImage)
                            .class("posts-image")
                        Div {
                            H3(item.title)
                            Paragraph(item.description)
                            Time(DateFormatter.time.string(from: item.date))
                        }
                    }
                    .class("posts-link")
                }
                .class("posts-article")
            }
            .class("posts-list")
        }
        .class("posts-list-")
    }
}
