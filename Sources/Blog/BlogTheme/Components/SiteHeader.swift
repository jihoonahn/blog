import Plot
import Publish

struct SiteHeader<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?
    
    var body: Component {
        Header {
            Wrapper {
                Navigation {
                    Node.a(
                        .href("/"),
                        .img(.alt("Blog Logo"), .src("/images/logo/logo.svg"))
                    ).class("blog-head-logo")
                    
                    List(Site.SectionID.allCases) { sectionID in
                        let section = context.sections[sectionID]
                        
                        return Link(section.title, url: section.path.absoluteString)
                            .class("blog-head-menu")
                    }
                }
            }
        }
    }
}
