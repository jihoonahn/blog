protocol AnyElement: Sendable {
    var name: String { get }
    var closingMode: ElementClosingMode { get }
    var paddingCharacter: Character? { get }
}
