import Plot
import Publish

extension Node where Context == HTML.DocumentContext {
    static func head(for page: Location, context: PublishingContext<Blog>) -> Node {
        return .group(
            .head(for: page, on: context.site, stylesheetPaths: [
                "/static/styles/default_style.css",
                "/static/styles/header_style.css",
                "/static/styles/footer_style.css"
            ]),
            .head(
                .googleFont(),
                .fontAwesome()
            )
        )
    }
}
