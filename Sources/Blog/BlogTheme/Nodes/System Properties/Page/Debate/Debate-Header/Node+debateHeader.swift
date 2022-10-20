import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func debateHeader() -> Node {
        return .article(
            .class("debate-card"),
            .header(
                .class("debate-card-header"),
                .img(
                    .class("debate-card-header-image"),
                    .src("/images/logo/AppleLogo.svg")
                )
            ),
            .footer(
                .class("debate-card-footer"),
                .h2(
                    .text("Debate")
                ),
                .p(
                    .text("Share all iOS related discussions or issues.")
                )
            )
        )
    }
}
