import Plot
import Publish

struct Footer: Component {
    var context: PublishingContext<Blog>

    var body: Component {
        Plot.Footer {
            Div {
                Div {
                    Div {
                        Paragraph {
                            Text("Copyright © ")
                            Link("Jihoonahn", url: "https://github.com/jihoonahn")
                        }
                    }
                    Div {
                        Paragraph {
                            Text("Made with Swift")
                        }
                    }
                }.class("copyright")
                Div {
                    List(context.site.socialMediaLinks) { socialMediaLink in
                        ListItem {
                            Link(url: socialMediaLink.url) {
                                Node.i(
                                    .class(socialMediaLink.icon)
                                )
                            }
                        }.class("social_link")
                    }
                }.class("social")
            }.class("site-footer__inner")
        }.class("site-footer")
    }
}
