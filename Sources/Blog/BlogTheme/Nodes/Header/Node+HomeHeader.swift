import Plot

extension Node where Context == HTML.BodyContext {
    
    private static var sections: [Blog.SectionID] { [.about,.posts,.notes] }
    
    
    static func homeheader(for site: Blog) -> Node {
        return .header(
            .class("site-header"),
            .div(
                .class("inner"),
                .div(
                    .class("site-header-content"),
                    .div(
                        .a(
                            .img(
                                .class("site-logo"),
                                .src("/images/logo/pelagornis.svg")
                            ),
                            .href("/")
                        )
                    ),
                    .h1(
                        .class("site-title"),
                        .text("JiHoonAHN's Blog")
                    ),
                    .h2(
                        .class("site-description"),
                        .text("iOS Learning Blog")
                    )
                ),
                .nav(
                    .class("site-nav"),
                    .a(
                        .class("menu-bar"),
                        .i(
                            .class("fas fa-bars")
                        ),
                        .href("#")
                    ),
                    .div(
                        .class("site-nav-left"),
                        .ul(
                            .class("nav"),
                            .li(
                                .a(
                                    .class("menu-item"),
                                    .text("Home"),
                                    .href("/")
                                )
                            ),
                            .forEach(sections, { section in
                                    .li(
                                        .a(
                                            .class("menu-item"),
                                            .text(section.name),
                                            .href(site.path(for: section))
                                        )
                                    )
                            })
                        )
                    ),
                    .div(
                        .class("site-nav-right"),
                        .div(
                            .class("social-links"),
                            .forEach(site.socialMediaLinks, { link in
                                .a(
                                    .class("socialmedia-item"),
                                    .i(
                                        .class(link.icon)
                                    ),
                                    .href(link.url)
                                )
                            })
                        )
                    )
                )
            )
        )
    }
}
