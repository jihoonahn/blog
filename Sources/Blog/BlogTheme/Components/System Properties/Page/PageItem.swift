import Plot
import Publish

struct PageItem: Component {
    var page: Page
    var context: PublishingContext<Blog>
    
    var body: Component {
        switch page.path.string {
        case "404":
            return ErrorPage()
        default:
            return page.body
        }
    }
}
