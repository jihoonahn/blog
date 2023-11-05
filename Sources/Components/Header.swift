import Plot
import Publish

struct Header: Component {
    var context: PublishingContext<Blog>
    
    var body: Component {
        Plot.Header {
            Div {
                Div {
                    Div {
                        Div {
                            Span().class("line-1")
                            Span().class("line-2")
                        }.class("menu-icon")
                    }.class("menu-icon-container")
                    Link(url: "/") {
                          Image(
                              url: "/static/images/Icon/icon.svg",
                              description: "Jihoonahn Blog"
                          )
                    }.class("blog-head-logo")
                    Div {
                        Div()
                            .id("docsearch")
                            .class("blog-search blog-icon-btn")
                    }.class("DocSearch-Button-container")
                }.class("blog-head-brand")
                Navigation {
                    List(Blog.SectionID.allCases) { sectionID in
                        let section = context.sections[sectionID]
                        return Link(
                            section.title,
                            url: section.path.absoluteString
                        ).class("nav-item")
                    }.class("nav")
                }.class("blog-head-menu")
            }.class("blog-head-inner inner")
        }
        .id("blog-head")
        .class("blog-head outer")
    }
}
