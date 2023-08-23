import Plot
import Publish

struct AboutPage: Component {
    let section: Publish.Section<Blog>
    
    var body: Component {
        SiteMain {
            Div {
                Div {
                    H2("About")
                    Image("/static/images/Blog/about/about.svg")
                }.class("site-section-header blog-canvas")
                Div {
                    Node.contentBody(section.body)
                }.class("site-section-body")
            }.class("inner")
        }
    }
}
