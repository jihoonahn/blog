import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func debatePage(for page: Page, on site: Blog) -> Node {
        return .div(
            .h1(
                .text("Hello")
            ),
            .h1(
                .text("Hello")
            ),
            .h1(
                .text("Hello")
            ),
            .h1(
                .text("Hello")
            )
        )
    }
}
