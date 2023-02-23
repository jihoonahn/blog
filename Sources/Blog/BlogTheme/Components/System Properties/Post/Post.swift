import Foundation
import Plot
import Publish

struct Post: Component {
    var item: Item<Blog>
    var context: PublishingContext<Blog>
    
    var body: Component {
        Article {
            Header {
                Div()
                    .class("site-post-head-image")
                    .style("background-image: url(/static/images/Blog/\(item.path.string).svg)")
            }.class("site-post-head")
            Div {
                H1 {
                    Text(item.title)
                }
                Section {
                    Time(DateFormatter.blogTime.string(from: item.date))
                    Span("|")
                        .class("date-divider")
                    for tag in item.tags {
                        Link("\(tag.string). ", url: context.site.url(for: tag))
                    }
                }.class("site-post-full-meta")
            }.class("site-post-head-title")
            Div {
                Div {
                    Node.contentBody(item.body)
                }
            }.class("site-post-body")
            NextAndPreview(context: context, item: item)
            Script(
                .src("https://utteranc.es/client.js"),
                .repo("JiHoonAHN/Blog"),
                .issue_term("pathname"),
                .label("comments"),
                .theme("github-light"),
                .crossorigin("anonymous"),
                .async()
            )
        }
    }
}
