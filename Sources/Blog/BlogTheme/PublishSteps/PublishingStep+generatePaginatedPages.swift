import Publish

extension PublishingStep where Site == Blog {
    static func generatePaginatedPages() -> Self {
        .group([
            .generatePaginatedIndexPages()
        ])
    }

    private static func generatePaginatedIndexPages() -> Self {
        .step(named: "Generate paginated index pages") { context in
            // dropFirst to avoid a duplicated Page 1 (Publish already added the first, original, index page)
            context.paginatedItems.indices.dropFirst().forEach { pageIndex in
                context.addPage(
                    Page(
                        path: context.index.paginatedPath(pageIndex: pageIndex),
                        content: .init(title: context.index.title, description: context.index.description, body: .init(components: {
                            IndexPage(
                                pageNumber: pageIndex + 1,
                                context: context
                            )
                        }), date: context.index.date, lastModified: context.index.lastModified, imagePath: context.index.imagePath)
                    )
                )
            }
        }
    }
}

