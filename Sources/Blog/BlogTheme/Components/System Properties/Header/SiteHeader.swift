import Plot
import Publish

struct SiteHeader<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?

    var body: Component {
        Header {
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
                            description: "JiHoonAHN Blog"
                        )
                    }.class("blog-head-logo")
                    Div()
                    .class("blog-search blog-icon-btn")
                    .id("docsearch")
                }.class("blog-head-brand")
                Navigation {
                    List(Site.SectionID.allCases) { sectionID in
                        let section = context.sections[sectionID]
                        return Link(
                            section.title,
                            url: section.path.absoluteString
                        ).class("nav-item")
                    }.class("nav")
                }.class("blog-head-menu")
                Div {
                    Div()
                    .class("blog-head-action")
                    .id("docsearch")
                }.class("container")
            }.class("blog-head-inner inner")
            Script(.src("/static/scripts/Header/header-scroll.js"))
            Script(.src("/static/scripts/Header/header-menu.js"))
            Script(.src("https://cdn.jsdelivr.net/npm/@docsearch/js@3"))
            Script(
                .type("text/javascript"),
                .src("/static/scripts/DocSearch/DocSearch.js")
            )
        }
        .id("blog-head")
        .class("blog-head outer")
    }
}
