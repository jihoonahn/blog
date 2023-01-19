import Plot
import Publish

struct ErrorPage: Component {
    var body: Component {
        SiteMain {
            Div {
                Section {
                    H1 {
                        Text("404")
                    }.class("error-title")
                    Paragraph("Page Not Found")
                        .class("error-description")
                    Link(url: "/") {
                        Text("Go to the front page ->")
                    }.class("error-homebutton")
                }.class("error-message")
            }.class("inner")
        }
    }
}
