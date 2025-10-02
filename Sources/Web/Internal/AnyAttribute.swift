protocol AnyAttribute: Sendable {
    var name: String { get }
    var value: String? { get set }
    var replaceExisting: Bool { get }

    func render() -> String
}

extension AnyAttribute {
    var nonEmptyValue: String? {
        value?.isEmpty == false ? value : nil
    }
}
