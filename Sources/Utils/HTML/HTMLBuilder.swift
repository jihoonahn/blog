import Plot

@resultBuilder
public struct HTMLBuilder {
    @inlinable
    public static func buildBlock<Content: HTMLConvertable>(_ content: Content) -> HTML {
        content.build()
    }
    @inlinable
    public static func buildOptional<H: HTMLConvertable>(_ wrapped: H?) -> HTML? {
        wrapped?.build()
    }
}
