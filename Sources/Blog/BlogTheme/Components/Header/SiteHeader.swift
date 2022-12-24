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
                        Image("static/images/logo/logo.svg")
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
//import Plot
//import Publish
//
//struct SiteHeader<Site: Website>: Component {
//    var context: PublishingContext<Site>
//    var selectedSelectionID: Site.SectionID?
//
//    var body: Component {
//        Header {
//            Navigation {
//                Div {
//                    Node.a(
//                        .href("/"),
//                        .img(.alt("blog Logo"), .src("/images/logo/logo.svg"))
//                    ).class("blog-head-logo")
//                    Div {
//                        Button {
//                            Node.i(
//                                .class("fa-solid fa-magnifying-glass")
//                            )
//                        }.class("blog-search")
//                        Button {
//                            Node.i(
//                                .class("fa-solid fa-bars")
//                            )
//                        }.class("blog-menu")
//                    }.class("blog-head-brand-wrapper")
//                }.class("blog-head-brand")
//                Div {
//                    List(Site.SectionID.allCases) { sectionID in
//                        let section = context.sections[sectionID]
//                        return Link(
//                            section.title,
//                            url: section.path.absoluteString
//                        ).class("nav-item")
//                    }.class("nav")
//                }.class("blog-head-menu")
//            }.class("blog-head-inner inner")
//            Script(.src("/js/Header/header-menu.js"))
//            Script(.src("/js/Header/header-scroll.js"))
//        }
//        .id("blog-head")
//        .class("blog-head outer")
//    }
//}
