struct PreviewPost: Component {
    var context: PublishingContext<Blog>
    var item: Item<Blog>
    
    var body: Component {
        Div {
            let items = context.allItems(sortedBy: \.date)
            let index = items.firstIndex(of: item) ?? 0
            let last = items.endIndex - 1
            Div {
                if index != 0 {
                    Link(url: items[index - 1].path.absoluteString) {
                        Div {
                            Paragraph("Preview Post")
                                .class("text-gray-500 m-0.5")
                            H3(items[index-1].title)
                                .class("text-black text-2xl font-medium m-0.5")
                        }
                        .class("flex-1 flex flex-col leading-none min-w-0 items-start")
                    }
                    .class("flex cursor-pointer rounded-[10px] bg-blog-c-preview-page w-full h-full p-4 min-h-[4.2rem] items-center")
                }
            }
            .class("min-w-0 flex-1 mt-4 md:mt-0")
            Div {
                if index < last {
                    Link(url: items[index + 1].path.absoluteString) {
                        Div {
                            Paragraph("Next Post")
                                .class("text-gray-500 m-0.5")
                            H3(items[index + 1].title)
                                .class("text-black text-2xl font-medium m-0.5")
                        }
                        .class("flex-1 flex flex-col leading-none min-w-0 items-end")
                    }
                    .class("flex cursor-pointer bg-blog-c-preview-page w-full h-full rounded-[10px] p-4 flex-row-reverse items-center min-h-[4.2rem]")
                }
            }
            .class("min-w-0 flex-1 mt-4 md:mt-0 md:ml-8")
        }
        .class("flex flex-col-reverse px-4 mt-11 mb-4 max-w-3xl mx-auto md:flex-row md:px-0")
    }
}
