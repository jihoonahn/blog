import Plot

extension Node where Context == HTML.BodyContext {
    private static var sections: [Blog.SectionID] { [.about,.posts,.notes] }
    
    static func header(for site: Blog) -> Node {
        return .header(
            
        )
    }
}
