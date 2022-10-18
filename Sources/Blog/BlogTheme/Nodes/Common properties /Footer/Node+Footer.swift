import Plot

extension Node where Context == HTML.BodyContext {
    
    static func footer(for site: Blog) -> Node {
        return .footer(
            .class("site-footer outer"),
            .div(
                .class("inner"),
                .section(
                    .class("copyright"),
                    .a(
                        .text("Pelagornis"),
                        .href("https://github.com/Pelagornis")
                    ),
                    .text(" © 2022")
                ),
                .nav(
                    .class("site-footer-nav"),
                    .ul(
                        .class("nav"),
                        .li(
                            .class("nav-list-item"),
                            .a(
                                .text("About"),
                                .href("/")
                            )
                        ),
                        .li(
                            .class("nav-list-item"),
                            .a(
                                .text("About"),
                                .href("/")
                            )
                        ),
                        .li(
                            .class("nav-list-item"),
                            .a(
                                .text("About"),
                                .href("/")
                            )
                        )
                    )
                ),
                .ul(
                    .class("site-footer-social-list"),
                    .forEach(site.socialMediaLinks, { socialMedia in
                            .li(
                                .class("site-footer-social-list-item"),
                                .a(
                                    .i(
                                        .class(socialMedia.icon)
                                    ),
                                    .href(socialMedia.url)
                                )
                            )
                    })
                )
            )
        )
    }
}
