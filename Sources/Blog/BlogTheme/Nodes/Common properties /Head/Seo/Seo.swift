import Plot

extension Node where Context == HTML.HeadContext {
    static func seo(for site : Blog, description: String? = nil) -> Node {
        return .group(
            .title("\(site.name)"),
            .meta(
                .name("description"),
                .content(site.description)
            ),
            .meta(
                .property("og:description"),
                .content(description ?? "")
            ),
            .meta(
                .property("og:url"),
                .content(site.url.description)
            ),
            .meta(
                .property("og:image"),
                .content("https://user-images.githubusercontent.com/68891494/197550122-5c52797f-4856-4949-8150-1f78e87d48c5.svg")
            ),
            .meta(
                .property("og:type"),
                .content("website")
            )
        )
    }
}

