struct PostLayout: Component {
    var item: Item<Blog>
    var context: PublishingContext<Blog>

    var body: Component {
        Section {
            Article {
                Div {
                    Div {
                        Div {
                            
                        }
                        .class("")
                    }
                    .class("")
                    Div {
                        Div {
                            
                        }
                        .class("")
                    }
                    .class("")
                    Div {
                        Div {
                            
                        }
                        .class("")
                    }
                    .class("")
                }
                .class("")
                Figure {
                    Div {
                        Image(item.metadata.postImage)
                    }
                }
                Div {
                    Div {
//                        Node.contentBody(item.body)
                    }
                }
                PreviewPost(context: context, item: item)
            }
        }
    }
}
