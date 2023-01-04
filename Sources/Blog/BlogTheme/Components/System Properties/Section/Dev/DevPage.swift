import Plot
import Publish

struct DevPage: Component {
    var section: Publish.Section<Blog>
    
    var body: Component {
        SiteMain {
            Div {
                Div {
                    H2("Dev")
                }.class("site-about-header")
                Div {
                    Node.contentBody(section.body)
                }.class("site-about-body")
            }.class("inner")
        }
    }
}
