struct PageLayout: Component {
    let title: String
    let component: () -> Component

    public init(
        title: String,
        component: @escaping () -> Component
    ) {
        self.title = title
        self.component = component
    }

    var body: Component {
        Section {
            H1(title)
                .id("pageTitle")
                .class("text-heading-2 font-semibold")
            component()
        }
        .class("px-4 sm:px-8 max-w-3xl mx-auto")
    }
}
