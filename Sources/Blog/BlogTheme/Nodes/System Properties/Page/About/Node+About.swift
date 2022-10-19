import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func aboutPage(for page: Page, on site: Blog) -> Node {
        return .main(
            .id("site-main"),
            .class("site-main outer"),
            .div(
                 .class("inner"),
                 .div(
                    .class("site-about-header"),
                    .h2(.text("About")),
                    .img(
                        .src("/images/logo/Pelagornis.jpg")
                    )
                 ),
                 .div(
                    .class("site-about-body"),
                    .contentBody(page.body)
                 )
            )
        )
    }
}
