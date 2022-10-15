import Plot

extension Node where Context == HTML.BodyContext {
    
    private static var sections: [Blog.SectionID] { [.debate,.notes,.about] }
    
    static func homeheader(for site: Blog) -> Node {
        return .header(
            .class("site-homeheader"),
            .div(
                .class("inner"),
                .div(
                    .class("site-homeheader-content"),
                    .div(
                        .a(
                            .img(
                                .class("site-homelogo"),
                                .src("/images/logo/pelagornis.svg")
                            ),
                            .href("/")
                        )
                    ),
                    .h1(
                        .class("site-home-title"),
                        .text("JiHoonAHN's Blog")
                    ),
                    .h2(
                        .class("site-home-description"),
                        .text("iOS Learning Blog")
                    )
                ),
                .nav(
                    .class("site-home-nav"),
                    .a(
                        .class("site-home-nav-toggleBtn"),
                        .i(
                            .class("fas fa-bars")
                        ),
                        .href("")
                    ),
                    .ul(
                        .class("site-home-nav-menu"),
                        .li(
                            .a(
                                .class("menu-homeitem"),
                                .text("Home"),
                                .href("/")
                            )
                        ),
                        .forEach(sections, { section in
                                .li(
                                    .a(
                                        .class("menu-homeitem"),
                                        .text(section.name),
                                        .href(site.path(for: section))
                                    )
                                )
                        })
                    ),
                    .ul(
                        .class("site-home-nav-socialLinks"),
                        .forEach(site.socialMediaLinks, { socialMediaLink in
                            .li(
                                .a(
                                    .class("social-homeitem"),
                                    .i(
                                        .class(socialMediaLink.icon)
                                    ),
                                    .href(socialMediaLink.url)
                                )
                            )
                        })
                    )
                )
            )
        )
    }
}
