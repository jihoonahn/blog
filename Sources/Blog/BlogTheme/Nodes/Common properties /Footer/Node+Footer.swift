import Plot

extension Node where Context == HTML.BodyContext {
    private static var sections: [Blog.SectionID] { [.posts,.notes,.about] }

    static func footer(for site: Blog) -> Node {
        return .footer(
            .class("site-footer"),
            .div(
                .class("footer-center"),
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
            .div(
                .class("footer-bottom"),
                .p(
                    .text("Copyright © 2022 JiHoonAHN. All rights reserved.")
                )
            )
        )
    }
}
