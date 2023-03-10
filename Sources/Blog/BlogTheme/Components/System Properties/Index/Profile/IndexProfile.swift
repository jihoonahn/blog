import Foundation
import Plot
import Publish

struct IndexProfile: Component {
    var context: PublishingContext<Blog>
    
    var body: Component {
        Div {
            H2("Profile").class("post-title")
            Div {
                Link(url: "https://linktr.ee/jihoonahn") {
                    Div {
                        Div {
                            Image("https://avatars.githubusercontent.com/u/68891494?v=4").class("profile-image")
                            H3("Jihoonahn")
                            Paragraph("Swift Developer")
                        }.class("profile-style")
                    }.class("profile-inner")
                }.class("profile-link")
            }
        }
    }
}
