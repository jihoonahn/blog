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
                                .class("blogDocsearch")
                        }
                        .class("flex items-center pl-4")
                        Button {
                            Span {
                                Span().class("top-0 left-0 absolute w-full h-0.5 bg-blog-c-nav-text translate-x-0 translate-y-0")
                                Span().class("top-1.5 left-0 absolute w-full h-0.5 bg-blog-c-nav-text translate-x-0 translate-y-0")
                                Span().class("top-3 left-0 absolute w-full h-0.5 bg-blog-c-nav-text translate-x-0 translate-y-0")
                            }
                            .class("relative h-4 w-4")
                        }
                        .id("mobileNavButton")
                        .accessibilityLabel("Mobile navigation")
                        .class("cursor-pointer flex w-10 h-blog-nav items-center justify-center md:hidden")
                    }
                    .class("flex justify-end items-center grow")
                    Navigation {
                        Link(url: "/") {
                            Text("Blog")
                        }
                        .class("blogNavBarMenuLink")
                        Link(url: "/about") {
                            Text("About")
                        }
                        .class("blogNavBarMenuLink")
                    }
                    .class("colum hidden md:flex")
                }
                .class("flex justify-between mx-auto my-0 max-w-3xl")
            }
            .class("pl-6 pr-4")
            Script(.src("https://cdn.jsdelivr.net/npm/@docsearch/js@3"))
            Script(.src("/static/scripts/header.js"))
            Script(
                .type("text/javascript"),
                .src("/static/scripts/docSearch.js")
            )
        }
        .id("header")
        .class("fixed top-0 left-0 w-full z-20 bg-blog-c-nav backdrop-saturate-125 backdrop-blur-xl")
    }
}
