import Plot

extension Node where Context == HTML.BodyContext {
    static func footer(for site: Blog) -> Node {
        return .footer(
            .class("site-footer")
        
        )
    }
}
