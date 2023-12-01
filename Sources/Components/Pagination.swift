struct Pagination: Component {
    let activePage: Int
    let numberOfPages: Int
    let pageURL: (_ pageNumber: Int) -> String
    let isDemo: Bool

    public init(activePage: Int, numberOfPages: Int, pageURL: @escaping (Int) -> String, isDemo: Bool = false) {
        self.activePage = activePage
        self.numberOfPages = numberOfPages
        self.pageURL = pageURL
        self.isDemo = isDemo
    }

    var body: Component {
        Navigation {
            Div {
                Div {
                    previewLink()
                }
                .class("blogPagination")
                Div {
                    Text("\(activePage) / \(numberOfPages)")
                }
                .class("flex-1-0 text-center")
                Div {
                    nextLink()
                }
                .class("blogPagination")
            }
            .class("flex relative px-4 items-center max-w-xs mx-auto my-0")
        }
        .id("pagination")
        .class("mt-16 mb-8")
        .accessibilityLabel("pagination number")
    }

    func generatePageURL(_ num: Int) -> String {
        if isDemo {
            return "#"
        } else {
            return pageURL(num)
        }
    }

    func previewLink() -> Component {
        let link: String
        if activePage == 1 {
            link = "#"
        } else {
            link = generatePageURL(activePage - 1)
        }
        let pageLink: Component = Link(url: link) {
            Image("/static/icons/arrow-left.svg")
                .class("h-4 w-4 p-0")
        }
        .class("flex h-9 w-9 items-center justify-center")
        return pageLink
    }

    func nextLink() -> Component {
        let link: String
        if activePage == numberOfPages {
            link = "#"
        } else {
            link = generatePageURL(activePage + 1)
        }
        let pageLink: Component = Link(url: link) {
            Image("/static/icons/arrow-right.svg")
                .class("h-4 w-4 p-0")
        }
        .class("flex h-9 w-9 items-center justify-center")
        return pageLink
    }
}
