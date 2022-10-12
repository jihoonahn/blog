import Plot

extension Node where Context == HTML.BodyContext {
    private static var sections: [Blog.SectionID] { [.about,.posts,.notes] }
    
    static func header(for site: Blog) -> Node {
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
                    )
                )
            )
        )
    }
}
