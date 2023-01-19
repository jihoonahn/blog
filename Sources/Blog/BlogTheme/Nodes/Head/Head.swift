import Plot
import Publish

extension Node where Context == HTML.DocumentContext {
    static func head(for page: Location, context: PublishingContext<Blog>) -> Node {
        return .group(
            .head(for: page, on: context.site, stylesheetPaths: [
                "/static/styles/default_style.css",
                "/static/styles/header_style.css",
                "/static/styles/home_style.css",
                "/static/styles/post_style.css",
                "/static/styles/about_style.css",
                "/static/styles/sectionPage_style.css",
                "/static/styles/errorPage_style.css",
                "/static/styles/footer_style.css",
                "/static/styles/tag_style.css",
                "/static/styles/tagDetail_style.css",
                "/static/styles/pagination_style.css"
            ]),
            .head(
                .googleFont(),
                .fontAwesome(),
                .jquery()
            )
        )
    }
}
