import Plot
import Publish

struct ContactPage: Component {
    var section: Publish.Section<Blog>

    var body: Component {
        SiteMain {
            Div {
                Div {
                    H2("Contact")
                }.class("site-section-header")
            }.class("inner")
        }
    }
}
