import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func page(for page: Page, context: PublishingContext<Blog>) -> Node {
        switch page.path.string {
        case Blog.SectionID.debate.rawValue: return debatePage(for: page, on: context)
        case Blog.SectionID.about.rawValue: return aboutPage(for: page, on: context.site)
        default: return .defaultPage(for: context.site)
        }
    }
}
