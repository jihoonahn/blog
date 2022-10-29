import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func defaultPage(for site: Blog) -> Node {
        return .main(
            .id("site-main"),
            .class("site-main outer"),
            .div(
                .class("inner"),
                .section(
                    .class("error-message"),
                    .h1(
                        .class("error-title"),
                        .text("404")
                    ),
                    .p(
                        .class("error-description"),
                        .text("Page not found")
                    ),
                    .a(
                        .class("error-homebutton"),
                        .text("Go to the front page →"),
                        .href("/")
                    )
                )
            )
        )
    }
}
