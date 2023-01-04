import Plot
import Publish

struct AboutPage: Component {
    var section: Publish.Section<Blog>
    
    var body: Component {
        SiteMain {
            Div {
                Div {
                    H2("About")
                    Image("/static/images/Blog/about/about.svg")
                }.class("site-about-header blog-canvas")
                Div {
                    Node.contentBody(section.body)
                }.class("site-about-body")
            }.class("inner")
        }
    }
}
