import Plot
import Publish

struct AboutPage: Component {
    var page: Publish.Page
    
    var body: Component {
        Main {
            Div {
                Div {
                    H2("About")
                }.class("site-about-header")
                Div {
                    Node.contentBody(page.body)
                }.class("site-about-body")
            }.class("inner")
        }
    }
}
