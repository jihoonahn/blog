struct AboutPage: Component {
    var body: Component {
        PageLayout(
            title: "About"
        ) {
            Div {
                Image("/static/images/about.svg")
                Paragraph {
                    Text("This blog is created using ")
                    Link("Publish", url: "https://github.com/JohnSundell/Publish")
                        .class("text-blog-c-brand")
                    Text(" and ")
                    Link("Tailwind CSS", url: "https://tailwindcss.com/")
                        .class("text-blog-c-brand")
                    Text(".")
                }
                .class("text-center")

                Paragraph("""
                I am a junior developer who started iOS development in 2021. During this time, I worked with small and large teams on the project. I am interested in various architectures and technologies while developing iOS.
                """)
                .class("font-light")
                
                Paragraph {
                    Text("You can contact me via ")
                    Link("Email", url: "mailto:jihoonahn.dev@gmail.com")
                        .class("text-blog-c-brand")
                    Text(" and ")
                    Link("LinkedIn", url: "https://www.linkedin.com/in/ahnjihoon/")
                        .class("text-blog-c-brand")
                    Text(".")
                }
            }
        }
    }
}
