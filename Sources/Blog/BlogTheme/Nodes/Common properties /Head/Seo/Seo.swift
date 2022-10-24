import Plot

extension Node where Context == HTML.HeadContext {
    static func seo(for site : Blog, title: String? = nil, description: String? = nil) -> Node {
        return .group(
            .title("\(site.name)"),
            .meta(
                .name("description"),
                .content(site.description)
            ),
            .meta(
                .property("og:title"),
                .content(title ?? "")
            ),
            .meta(
                .property("og:description"),
                .content(description ?? "")
            ),
            .meta(
                .property("og:image"),
                .content("/images/Icon/icon.svg")
            ),
            .meta(
                .property("og:type"),
                .content("website")
            )
        )
    }
}
