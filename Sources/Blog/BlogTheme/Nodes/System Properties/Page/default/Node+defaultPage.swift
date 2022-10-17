import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    
    static func defaultPage(for page: Page, on site: Blog) -> Node {
        return .div(
            .class("default-page-wrapper"),
            .h2(
                .class("default-page-title"),
                .text(page.title)
            ),
            .div(
                .class("default-page-description"),
                .contentBody(page.body)
            )
        )
    }
}
