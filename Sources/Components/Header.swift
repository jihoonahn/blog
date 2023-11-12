struct Header: Component {
    var context: PublishingContext<Blog>
    
    var body: Component {
        Plot.Header {
            Div {
                Div {
                    Link(url: "/") {
                        Image("/static/images/icon.svg")
                            .class("max-h-11")
                    }
                    .class("flex items-center h-blog-nav")
                    Div {
                        Div {
                            Div()
                                .id("docsearch")
                                .class("BlogDocsearch")
                        }
                        .class("flex items-center pl-4")
                        Navigation {
                            Link(url: "/") {
                                Text("Blog")
                            }
                            .class("BlogNavBarMenuLink")
                            Link(url: "/about") {
                                Text("About")
                            }
                            .class("BlogNavBarMenuLink")
                        }
                        .class("hidden md:flex")
                    }
                    .class("flex justify-end items-center grow")
                }
                .class("flex justify-between mx-auto my-0 max-w-3xl")
            }
            .class("bg-blog-c-nav backdrop-saturate-125 backdrop-blur-xl pl-6 pr-4")
            Script(.src("https://cdn.jsdelivr.net/npm/@docsearch/js@3"))
            Script(.src("/static/scripts/header.js"))
            Script(
                .type("text/javascript"),
                .src("/static/scripts/docSearch.js")
            )
        }
        .class("fixed top-0 left-0 w-full z-20")
    }
}
