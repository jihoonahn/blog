import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func debatePage(for page: Page, on context: PublishingContext<Blog>) -> Node {
        let items = context.allItems(sortedBy: \.date, order: .descending).filter{ $0.sectionID == .debate}
        
        return .div(
            .class("debate-wrapper"),
            .div(
                .class("debate-title"),
                .h1(
                    .class("debate-title-text"),
                    .text("Recent debate")
                ),
                .forEach(items) { item in
                    .section(
                        .class("debate-post"),
                        .header(
                            .class("debate-post-header"),
                            .h2(
                                .class("debate-post-title"),
                                .a(
                                    .text(item.title),
                                    .href(item.path)
                                )
                            ),
                            .p(
                                .class("debate-post-date"),
                                .text(DateFormatter.blog.string(from: item.date))
                            )
                        ),
                        .div(
                            .class("debate-post-description"),
                            .p(.text(item.metadata.excerpt))
                        )
                    )
                }
            )
        )
    }
}
