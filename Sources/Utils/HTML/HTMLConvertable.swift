import Plot

public protocol HTMLConvertable {
    func build() -> HTML
}

extension HTML: HTMLConvertable {
    public func build() -> HTML {
        return self
    }
}
