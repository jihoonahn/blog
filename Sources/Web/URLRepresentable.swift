import Foundation

/// Protocol adopted by types that can represent a URL, which
/// can then be converted into a string using the `description`
/// property. `URL` and `String` conforms to this protocol.
public protocol URLRepresentable: CustomStringConvertible, Sendable {}

extension URL: URLRepresentable {}
extension String: URLRepresentable {}

extension URLRepresentable {
    var string: String { description }
}
