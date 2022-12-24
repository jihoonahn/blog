import Plot
import Publish

struct SiteHeader<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?
    
    var body: Component {
        Header {
            Navigation {
                Div {
                    Link(url: "/") {
                        Image("/static/images/logo/logo.svg")
                    }
                }.class("nav__logo-container")
                Div {
                    Button {
                        Node.i(
                            .class("fa-solid fa-bars")
                        )
                    }.class("nav__menu")
                    List(Site.SectionID.allCases) { sectionID in
                        let section = context.sections[sectionID]
                        return Link(section.title,
                                    url: section.path.absoluteString
                        ).class("nav__section-item")
                    }.class("nav__section")
                }.class("nav__content")
                Div {
                    Button {
                        Node.i(
                            .class("fa-solid fa-magnifying-glass")
                        )
                    }
                }.class("nav__search")
            }.class("nav")
            Script(.src("/js/Header/header-menu.js"))
            Script(.src("/js/Header/header-scroll.js"))
        }.class("site-header")
    }
}
