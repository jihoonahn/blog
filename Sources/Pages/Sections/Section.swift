struct SectionPage: Component {
    var section: Publish.Section<Blog>
    var context: PublishingContext<Blog>

    var body: Component {
        switch section.path.string {
        case Blog.SectionID.blog.rawValue:
            return IndexPage(pageNumber: 1, context: context)
        case Blog.SectionID.about.rawValue:
            return AboutPage()
        default: return Div()
        }
    }
}
