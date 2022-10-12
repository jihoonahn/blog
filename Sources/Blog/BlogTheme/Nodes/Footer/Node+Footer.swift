import Plot

extension Node where Context == HTML.BodyContext {
    private static var sections: [Blog.SectionID] { [.about,.posts,.notes] }
    
    static func footer(for site: Blog) -> Node {
        return .footer(
            .class("site-footer"),
            .div(
                .class("footer-left"),
                .h1(
                    .img(
                        .class("footer-logo"),
                        .src("/images/logo/pelagornis.svg")
                    )
                ),
                .p(
                    .text("Welcome to JiHoonAHN's blog")
                )
            ),
            .ul(
                .class("footer-right"),
                .li(
                    .h2(
                        .text("Explore")
                    ),
                    .ul(
                        .class("box"),
                        .li(
                            .a(
                                .text("Home"),
                                .href("/")
                            )
                        ),
                        .forEach(sections, { section in
                                .li(
                                    .a(
                                        .text(section.name),
                                        .href(site.path(for: section))
                                    )
                                )
                        })
                    )
                ),
                .li(
                    .h2(
                        .text("Information")
                    ),
                    .ul(
                        .class("box"),
                        .forEach(site.information, { information in
                                .li(
                                    .a(
                                        .text(information),
                                        .href(information)
                                    )
                                )
                        })
                    )
                    
                ),
                .li(
                    .h2(
                        .text("More")
                    ),
                    .ul(
                        .class("box"),
                        .forEach(site.socialMediaLinks, { link in
                                .li(
                                    .a(
                                        .text(link.title),
                                        .href(link.url)
                                    )
                                )
                        })
                    )
                    
                )
            ),
            .div(
                .class("footer-bottom"),
                .p(
                    .text("Copyright © 2022 JiHoonAHN. All rights reserved.")
                )
            )
        )
    }
}
