struct ErrorPage: Component {
    var body: Component {
        Section {
            Div {
                Div {
                    H2 {
                        Span {
                            Text("404")
                        }
                        .class("text-blog-c-brand")
                    }
                    .class("mb-8 font-bold text-9xl")
                    Paragraph("Sorry, we couldn't find this page.")
                        .class("text-3xl font-semibold md:text-3xl")
                    Link(url: "/") {
                        Text("Back to homepage")
                    }
                    .class("inline-flex cursor-pointer justify-center rounded-full p-5 text-gray-500 text-center border-2 ml-4")
                }
                .class("max-w-md text-center")
            }
            .class("flex items-center container flex-col justify-center mx-auto my-8 px-5")
        }
        .class("flex items-center h-full p-16")
    }
}
