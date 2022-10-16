import Plot

extension Node where Context == HTML.HeadContext {
    static func script_Links() -> Node {
        return .group(
            .script(
                .src("/js/Header/header-menu.js"),
                .defer()
            ),
            .script(
                .src("/js/Header/header-scroll.js"),
                .defer()
            ),
            .script(
                .src("https://code.jquery.com/jquery-3.5.1.min.js"),
                .integrity("sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="),
                .crossorigin("anonymous")
            ),
            .script(
                .src("https://kit.fontawesome.com/662f6d0c39.js"),
                .crossorigin("anonymous")
            )
        )
    }
}

