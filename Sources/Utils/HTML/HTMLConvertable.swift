protocol HTMLConvertable {
    func build() -> HTML
}

extension HTML: HTMLConvertable {
    func build() -> HTML {
        return self
    }
}
