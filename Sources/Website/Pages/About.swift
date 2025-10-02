import Web
import Generator

@HTMLBuilder
func about() -> HTML {
    let metadata = SiteMetaData(title: "About")
    let social: [SocialMediaLink] = [.email, .github, .linkedIn, .resume, .rss]
    Layout(
        metadata: metadata
    ) {
        Main {
            Div {
                Image("/image/aboutHeader.svg")
                    .class("w-full h-full rounded-3xl overflow-hidden")
            }
            .class("max-w-4xl mx-auto px-6 pt-32")
            Paragraph {
                Text("This website is created using ")
                Link("Swift", url: "https://github.com/swiftlang/swift")
                    .class("text-red-500")
                Text(".")
            }
            .class("text-center pt-8")
            Div {
                Paragraph("""
                    I am a junior iOS developer who began my journey in 2021. Over the past few years, I have collaborated with both small and large teams on various projects. I have a strong interest in exploring different architectures and technologies while building iOS applications.
                """)
                .class("font-light")
            }
            .class("max-w-2xl mx-auto pt-8 px-6")
            Div {
                ComponentGroup(members: social.map({ link in
                    SocialLink(title: link.title, description: link.description, url: link.url, icon: link.icon)
                }))
                .class("mt-4")
            }
            .class("max-w-2xl mx-auto pt-8 px-6")
        }
        .class("min-h-screen")
    }
}
