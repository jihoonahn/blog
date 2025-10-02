internal extension Character {
    var isSameLineWhitespace: Bool {
        isWhitespace && !isNewline
    }
}

internal extension Set where Element == Character {
    static let boldItalicStyleMarkers: Self = ["*", "_"]
    static let allStyleMarkers: Self = boldItalicStyleMarkers.union(["~"])
}
