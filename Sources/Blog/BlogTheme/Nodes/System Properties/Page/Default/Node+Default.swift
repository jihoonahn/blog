import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func defaultPage(for page: Page, on site: Blog) -> Node {
        return .main(
            .id("site-main"),
            .class("site-main outer"),
                .div(
                 .class("inner"),
                    .h2(
                        .class("post-title"),
                        .text(page.title)
                    ),
                 .div(
                    .class("post-description"),
                    .div(
                        .contentBody(page.body)
                    )
                 )
            )
        )
    }
}
