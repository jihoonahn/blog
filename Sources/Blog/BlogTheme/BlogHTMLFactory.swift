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
                    SiteMain {
                        IndexPage(
                            context: context,
                            items: context.allItems(
                                sortedBy: \.date,
                                order: .descending)
                            .filter { $0.sectionID == .posts }
                        )
                    }
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
                    Div{
                        H1(section.title)
                    }
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
                    Post(item: item, context: context)
                    Script(.src("/static/scripts/Channel_talk/Channel_talk.js"))
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
                Wrapper {
                    Page(page: page, context: context)
                    Script(.src("/static/scripts/Channel_talk/Channel_talk.js"))
                }
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
                    TagList(tags: page.tags.reversed(), context: context)
                    Script(.src("/static/scripts/Channel_talk/Channel_talk.js"))
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
                    TagDetail(items: context.items(taggedWith: page.tag,
                                                   sortedBy: \.date),
                              context: context,
                              title: "\(page.tag.string.capitalized)"
                    )
                    Script(.src("/static/scripts/Channel_talk/Channel_talk.js"))
                }
                SiteFooter(context: context)
            }
        )
    }
}
