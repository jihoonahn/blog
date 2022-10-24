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
                .property("og:site_name"),
                .content(site.name)
            ),
            .meta(
                .property("og:description"),
                .content(description ?? "")
            ),
            .meta(
                .property("og:image"),
                .content("https://user-images.githubusercontent.com/68891494/197516699-9eff2b66-1470-4777-bfb6-dcbf11e24eb3.svg")
            ),
            .meta(
                .property("og:type"),
                .content("website")
            )
        )
    }
}
