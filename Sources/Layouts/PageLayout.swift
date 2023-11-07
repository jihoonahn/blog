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
        Div {
            H1(title)
            component()
        }
    }
}
