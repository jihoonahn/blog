import Plot

extension Node where Context == HTML.HeadContext {
    static func script_Links() -> Node {
        return .group(
            .script(
                .src("https://kit.fontawesome.com/662f6d0c39.js"),
                .crossorigin("anonymous")
            ),
            .script(
                .src("https://code.jquery.com/jquery-3.5.1.min.js"),
                .integrity("sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="),
                .crossorigin("anonymous")
            )
        )
    }
}
