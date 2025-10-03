import Web

struct Header: Component {
    
    var body: Component {
        Web.Header {
            Navigation {
                ComponentGroup(members: navigation.map { item in
                    Tooltip(text: item.name, position: .bottom) {
                        Link(url: item.href) {
                            item.icon
                        }
                        .class("flex items-center justify-center hover:bg-neutral-800 hover:text-neutral-400 rounded-full transition-colors duration-200 text-neutral-600 w-12 h-12")
                    }
                })
            }
            .class("flex space-x-3 header-container")
            
            Div {
                Div {
                    Div().id("docsearch")
                }
                .class("flex items-center justify-center hover:bg-neutral-800 hover:text-neutral-400 rounded-full transition-colors duration-200 text-neutral-600 w-12 h-12")
            }
            .class("header-container")
            Script()
                .attribute(named: "src", value: "https://cdn.jsdelivr.net/npm/@docsearch/js@4")
            Script()
                .attribute(named: "type", value: "text/javascript")
                .attribute(named: "src", value: "/scripts/docsearch.js")
        }
        .class("fixed top-8 left-0 right-0 flex justify-between items-center px-6 max-w-2xl mx-auto z-99")
    }
}
