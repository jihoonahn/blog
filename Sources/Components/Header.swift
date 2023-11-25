struct Header: Component {
    var context: PublishingContext<Blog>
    
    var body: Component {
        Plot.Header {
            Div {
                Div {
                    Link(url: "/") {
                        Image("/static/images/icon.svg")
                            .class("max-h-11 p-0")
                    }
                    .class("flex items-center h-blog-nav")
                    Div {
                        Button {
                            Span {
                                Span().class("transition duration-200 top-0 left-0 absolute w-full h-0.5 bg-blog-c-nav-text ease translate-x-0 translate-y-0 group-[.expanded]:rotate-45 group-[.expanded]:translate-y-0 group-[.expanded]:top-1.5")
                                Span().class("transition duration-200 top-1.5 left-0 absolute w-full h-0.5 bg-blog-c-nav-text ease translate-x-0 translate-y-0 group-[.expanded]:opacity-0")
                                Span().class("transition duration-200 top-3 left-0 absolute w-full h-0.5 bg-blog-c-nav-text ease translate-x-0 translate-y-0 group-[.expanded]:-rotate-45 group-[.expanded]:-translate-y-0 group-[.expanded]:top-1.5")
                            }
                            .class("relative h-4 w-4 overflow-hidden")
                        }
                        .id("mobileNavButton")
                        .accessibilityLabel("Mobile navigation")
                        .class("cursor-pointer flex w-10 h-blog-nav items-center justify-center group md:hidden")
                    }
                    .class("flex justify-end items-center grow")
                    Navigation {
                        List(Blog.SectionID.allCases) { sectionID in
                            Link(
                                context.sections[sectionID].title,
                                url: context.sections[sectionID].path.absoluteString
                            )
                            .class("blogNavBarMenuLink block py-0 px-3 text-xs leading-calc-blog-nav")
                        }
                        .class("flex list-none m-0")
                    }
                    .class("hidden md:flex")
                }
                .class("flex justify-between mx-auto my-0 max-w-3xl")
                Div {
                    Div {
                        Navigation {
                            List(Blog.SectionID.allCases) { sectionID in
                                Link(
                                    context.sections[sectionID].title,
                                    url: context.sections[sectionID].path.absoluteString
                                )
                                .class("block py-3 blogNavBarMenuLink border-b border-zinc-500 border-solid")
                            }
                            .class("list-none m-0")
                        }
                        .class("inline")
                        Div {
                            List(context.site.socialMediaLinks) { socialMediaLink in
                                Link(url: socialMediaLink.url) {
                                    Image(socialMediaLink.icon)
                                        .class("w-6 h-6 rounded-none")
                                }
                                .class("text-center w-6 h-6")
                            }
                            .class("flex justify-center gap-4 list-none")
                        }
                        .class("mt-4 w-full")
                    }
                    .class("my-0 mx-auto max-w-[288px] pt-6 pb-24")
                }
                .id("blogNavScreen")
                .class("hidden h-screen")
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
