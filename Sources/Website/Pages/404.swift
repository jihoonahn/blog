import Web
import Generator

@HTMLBuilder
func error() -> HTML {
    let metadata = SiteMetaData(
        title: "404",
        description: "Not Found",
    )

    Layout(
        metadata: metadata
    ) {
        Main {
            Div {
                Div {
                    Div {
                        H2 {
                            Text("Page Not Found")
                        }
                        .class("mb-8 font-bold text-7xl")
                        Paragraph("Sorry, we couldn't find this page.")
                            .class("text-3xl font-semibold md:text-3xl")
                    }
                    .class("max-w-md text-center")
                    
                }
                .class("flex items-center container flex-col justify-center mx-auto my-8 px-5")
            }
            .class("flex items-center h-full pb-24 pt-64")
        }
        .class("min-h-screen")
    }
}
