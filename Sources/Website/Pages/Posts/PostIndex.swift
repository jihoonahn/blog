import Foundation
import Web
import Generator

@HTMLBuilder
func postIndex(posts: [Post]) -> HTML {
    let metadata = SiteMetaData(title: "Blog")

    Layout(
        metadata: metadata
    ) {
        Main {
            Div {
                Div {
                    List(posts.sorted { $0.metadata.date > $1.metadata.date }) { post in
                        ListItem {
                            Link(url: "/posts/\(post.slug)/") {
                                PostCard(post: post)
                            }
                            .class("block")
                        }
                    }
                    .class("grid grid-cols-1 gap-6")
                }
            }
            .class("max-w-2xl mx-auto px-6 pb-24 pt-32")
        }
        .class("min-h-screen")
    }
}
