@resultBuilder
struct HTMLBuilder {
    @inlinable
    static func buildBlock<Content: HTMLConvertable>(_ content: Content) -> HTML {
        content.build()
    }
    @inlinable
    static func buildOptional<H: HTMLConvertable>(_ wrapped: H?) -> HTML? {
        wrapped?.build()
    }
}
