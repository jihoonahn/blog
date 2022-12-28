import Plot
import Publish
import Foundation

struct BlogHTMLFactory: HTMLFactory {
    typealias Site = Blog

    func makeIndexHTML(for index: Publish.Index,
                       context: Publish.PublishingContext<Blog>) throws -> Plot.HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, context: context),
            .body {
                SiteHeader(context: context)
                Wrapper {
                    H1(context.site.name)
                    Script(.src("/static/scripts/Channel_talk/Channel_talk.js"))
                }
                SiteFooter(context: context)
            }
        )
    }
    
    func makeSectionHTML(for section: Publish.Section<Blog>,
                         context: Publish.PublishingContext<Blog>) throws -> Plot.HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, context: context),
            .body {
                SiteHeader(context: context)
                Wrapper {
                    H1(section.title)
                    Script(.src("/static/scripts/Channel_talk/Channel_talk.js"))
                }
                SiteFooter(context: context)
            }
        )
    }
    
    func makeItemHTML(for item: Publish.Item<Blog>,
                      context: Publish.PublishingContext<Blog>) throws -> Plot.HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, context: context),
            .body {
                SiteHeader(context: context)
                Wrapper {
                    H1(item.title)
                    Script(.src("/static/scripts/Channel_talk.js"))
                }
                SiteFooter(context: context)
            }
        )
    }
    
    func makePageHTML(for page: Publish.Page,
                      context: Publish.PublishingContext<Blog>) throws -> Plot.HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, context: context),
            .body {
                SiteHeader(context: context)
                Wrapper (page.body)
                SiteFooter(context: context)
            }
        )
    }
    
    func makeTagListHTML(for page: Publish.TagListPage,
                         context: Publish.PublishingContext<Blog>) throws -> Plot.HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, context: context),
            .body {
                SiteHeader(context: context)
                Wrapper {
                    Script(.src("/static/scripts/Channel_talk.js"))
                }
                SiteFooter(context: context)
            }
        )
    }
    
    func makeTagDetailsHTML(for page: Publish.TagDetailsPage,
                            context: Publish.PublishingContext<Blog>) throws -> Plot.HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, context: context),
            .body {
                SiteHeader(context: context)
                Wrapper {
                    Script(.src("/static/scripts/Channel_talk.js"))
                }
                SiteFooter(context: context)
            }
        )
    }
}
