import Plot
import Publish

struct SiteHeader<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?
    
    var body: Component {
        Header {
            Div {
                Div {
                    Button {
                        Node.i(
                            .class("fa-solid fa-bars")
                        )
                    }.class("blog-menu blog-icon-btn")
                    Link(url: "/") {
                        Image(
                            url: "/static/images/Icon/icon.svg",
                            description: "JiHoonAHN Blog"
                        )
                    }.class("blog-head-logo")
                    Button {
                        Node.i(
                            .class("fa-solid fa-magnifying-glass")
                        )
                    }.class("blog-search blog-icon-btn")
                }.class("blog-head-brand")
                Navigation {
                    List(Site.SectionID.allCases) { sectionID in
                        let section = context.sections[sectionID]
                        return Link(section.title, url: section.path.absoluteString)
                    }.class("nav")
                }.class("blog-head-menu")
                Div {
                    Button {
                        Node.i(
                            .class("fa-solid fa-magnifying-glass")
                        )
                    }.class("blog-search blog-icon-btn")
                }.class("blog-head-action")
            }.class("blog-head-inner inner")
            Script(.src("/js/Header/header-menu.js"))
            Script(.src("/js/Header/header-scroll.js"))
        }
        .id("blog-head")
        .class("blog-head outer")
    }
}
