struct PagePage: Component {
    let page: Page
    let context: PublishingContext<Blog>

    var body: Component {
        switch page.path.string {
        case "404":
            return ErrorPage()
        default:
            return page.body
        }
    }
}
