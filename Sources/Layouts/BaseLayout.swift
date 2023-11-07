import Plot
import Publish

struct BaseLayout: HTMLConvertable {
    // MARK: - Property
    var location: Location
    var context: PublishingContext<Blog>
    var component: () -> Component

    public init(
        for location: Location,
        context: PublishingContext<Blog>,
        component: @escaping () -> Component
    ) {
        self.location = location
        self.context = context
        self.component = component
    }
    
    func build() -> Plot.HTML {
        HTML(
            .head(for: location, context: context),
            .body {
                Header(context: context)
                Main {
                    component()
                }
                .id("main")
                Footer(context: context)
            }
        )
    }
}
