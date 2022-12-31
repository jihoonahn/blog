import Plot
import Publish

struct Page: Component {
    var page: Publish.Page
    var context: PublishingContext<Blog>

    var body: Component {
        switch page.path.string {
        case Blog.SectionID.about.rawValue: return AboutPage(page: page)
        default: return DefaultPage()
        }
    }
}
