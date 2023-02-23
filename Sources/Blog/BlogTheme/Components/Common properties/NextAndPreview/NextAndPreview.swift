import Plot
import Publish

struct NextAndPreview: Component {
    
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
                            H3(items[index-1].title).class("preview-title")
                        }.class("preview-textdir")
                    }.class("preview-link")
                }
            }.class("preview-container")
            Div {
                if index < last {
                    Link(url: items[index + 1].path.absoluteString) {
                        Div {
                            Paragraph("Next Post")
                            H3(items[index+1].title).class("next-title")
                        }.class("next-textdir")
                    }.class("next-link")
                }
            }.class("next-container")
        }.class("nextAndPreview")
    }
}
//context.allItems(sortedBy: \.date)
