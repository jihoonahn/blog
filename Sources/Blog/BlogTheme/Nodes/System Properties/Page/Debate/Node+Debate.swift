import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func debatePage(for page: Page, on context: PublishingContext<Blog>) -> Node {
        let items = context.allItems(sortedBy: \.date, order: .descending).filter{ $0.sectionID == .debate}

        return .main(
            .id("site-main"),
            .class("site-main outer"),
            .div(
                 .class("inner"),
                 .div(
                    .class("site-debate-header"),
                    .div(
                        .class("site-debate-header-inner"),
                        .div(
                            .class("site-debate-header-left-view"),
                            .div(
                                .class("site-debate-header-view-image"),
                                .img(
                                    .src("/images/logo/AppleLogo.svg")
                                )
                            )
                        ),
                        .div(
                            .class("site-debate-header-right-view"),
                            .div(
                                .class("site-debate-header-view-text-head"),
                                .h2(
                                    .text("Debate")
                                )
                            ),
                            .div(
                                .class("site-debate-header-view-text-foot"),
                                .p(
                                    .text("Share all iOS related discussions or issues.")
                                )
                            )
                        )
                    )
                 ),
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
                                 .a(
                                    .class("debate-post-title"),
                                    .h2(
                                        text(item.title)
                                    ),
                                    .href(item.path)
                                 ),
                                 .p(
                                     .class("debate-post-description"),
                                     .text(item.metadata.excerpt)
                                 )
                             ),
                             .div(
                                .p(
                                    .class("debate-post-date"),
                                    .text(DateFormatter.blog.string(from: item.date))
                                )
                             )
                         )
                     }
                 )
             )
        )
    }
}
