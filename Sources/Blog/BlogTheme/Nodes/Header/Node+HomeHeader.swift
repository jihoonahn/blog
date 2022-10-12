import Plot

extension Node where Context == HTML.BodyContext {
    
    private static var sections: [Blog.SectionID] { [.about,.posts,.notes] }
    
    
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
                        .class("site-hometitle"),
                        .text("JiHoonAHN's Blog")
                    ),
                    .h2(
                        .class("site-homedescription"),
                        .text("iOS Learning Blog")
                    )
                ),
                .nav(
                    .class("site-homenav"),
                    .a(
                        .class("menu-bar"),
                        .i(
                            .class("fas fa-bars")
                        ),
                        .href("#")
                    ),
                    .div(
                        .class("site-homenav-left"),
                        .ul(
                            .class("homenav"),
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
                        .class("site-homenav-right"),
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
