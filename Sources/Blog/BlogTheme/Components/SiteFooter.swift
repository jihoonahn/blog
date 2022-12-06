import Plot
import Publish

struct SiteFooter: Component {
    var context: PublishingContext<Blog>
    
    var body: Component {
        Footer {
            Div {
                Div {
                    Node.a(
                        .href("https://github.com/Pelagornis"),
                        .text("Pelagornis")
                    )
                    Text(" © 2022")
                }.class("copyright")
                Navigation {
                    List(context.sections.ids) { sectionID in
                        let section = context.sections[sectionID]
                        
                        return Link(section.title,
                                    url: section.path.absoluteString
                        ).class("nav-list-item")
                    }.class("nav")
                }.class("site-footer-nav")
                List(context.site.socialMediaLinks) { socialMedia in
                    ListItem {
                        Node.a(
                            .i(.class(socialMedia.icon)),
                            .href(socialMedia.url)
                        )
                    }.class("site-footer-social-list-item")
                }.class("site-footer-social-list")
            }.class("inner")
        }.class("site-footer outer")
    }
}
