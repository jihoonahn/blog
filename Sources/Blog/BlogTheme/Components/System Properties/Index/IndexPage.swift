import Plot
import Publish

struct IndexPage: Component {
    var context: PublishingContext<Blog>
    var items: [Item<Blog>]

    var body: Component {
        Main {
            Div {
                Div {
                    for item in items {
                        Posts(item: item, context: context)
                    }
                }.class("post-feed")
            }.class("inner")
        }
    }
}
