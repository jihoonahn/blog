struct ArchiveLayout: Component {
    let title: String
    let items: [Item<Blog>]
    let context: PublishingContext<Blog>

    var body: Component {
        Div {
            H1(title)
                .class("text-heading-2 font-semibold")
            Section {
                Div {
                    
                }
            }
        }
        .class("px-4 sm:px-8 max-w-3xl mx-auto")
    }
}
