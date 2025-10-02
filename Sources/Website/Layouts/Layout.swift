import Web
import Generator

struct Layout: HTMLConvertable {
    let metadata: SiteMetaData
    let content: () -> Component

    func build() -> HTML {
        HTML(
            .head(site: metadata),
            .body {
                Header()
                content()
                Footer()
            }
        )
    }
}
