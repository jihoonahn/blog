import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    private static var sections: [Blog.SectionID] { [.debate,.about] }
    
    static func header(for site: Blog) -> Node {
        return .header(
            .id("blog-head"),
            .class("blog-head outer"),
            .nav(
                .class("blog-head-inner inner"),
                .div(
                    .class("blog-head-brand"),
                    .a(
                        .class("blog-head-logo"),
                        .img(.src("/images/logo/logo.svg")),
                        .href("/")
                    ),
                    .div(
                        .class("blog-head-brand-wrapper"),
                        .button(
                            .class("blog-search"),
                            .i(
                                .class("fa-solid fa-magnifying-glass")
                            )
                        ),
                        .button(
                            .class("blog-menu"),
                            .i(
                                .class("fa-solid fa-bars")
                            )
                        )
                    )
                ),
                .div(
                    .class("blog-head-menu"),
                    .ul(
                        .class("nav"),
                        .li(
                            .class("nav-item"),
                            .a(
                                .text("Home"),
                                .href("/")
                            )
                        ),
                        .forEach(sections) { section in
                                .li(
                                    .class("nav-item"),
                                    .a(
                                        .text(section.name),
                                        .href(site.path(for: section))
                                    )
                                )
                        }
                    )
                ),
                .div(
                    .class("blog-head-actions"),
                    .button(
                        .class("blog-search"),
                        .i(
                            .class("fa-solid fa-magnifying-glass")
                        )
                    )
                )
            ),
            .script(
                .src("/js/Header/header-menu.js"),
                .defer()
            ),
            .script(
                .src("/js/Header/header-scroll.js"),
                .defer()
            )
        )
    }
}
