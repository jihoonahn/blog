import Plot
import Publish

struct PostLayout: Component {
    var item: Item<Blog>
    var context: PublishingContext<Blog>

    var body: Component {
        Div() {}
    }
}
