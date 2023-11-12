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
                Script(
                    .src("https://utteranc.es/client.js"),
                    .repo("jihoonahn/blog"),
                    .issue_term("pathname"),
                    .label("comments"),
                    .theme("github-light"),
                    .crossorigin("anonymous"),
                    .async()
                )
                .style("""
                .utterances {
                    border-radius: 10px;
                    background: #f6f8fa;
                    max-width: 768px;
                }

                .utterances-frame {
                    padding-left: 1rem;
                    padding-right: 1rem;
                }
                """)
            }
        }
    }
}
