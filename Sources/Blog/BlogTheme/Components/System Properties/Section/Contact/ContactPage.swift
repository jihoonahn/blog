import Plot
import Publish

struct InfoPage: Component {
    var section: Publish.Section<Blog>

    var body: Component {
        SiteMain {
            Div {
                Div {
                    H2("JiHoonAHN")
                }.class("site-section-header")
            }.class("inner")
        }
    }
}
