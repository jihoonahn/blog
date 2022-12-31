import Plot
import Publish

struct SiteMain: ComponentContainer {
    @ComponentBuilder var content: ContentProvider
    
    var body: Component {
        Main(content: content).id("site-main").class("site-main outer")
    }
}
