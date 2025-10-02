import Foundation

/// Enum describing various HTTP request methods that can
/// be used when submitting an HTML `<form>`.
public enum HTMLFormMethod: String, RawRepresentable, Sendable {
    /// Use a `GET` request.
    case get
    /// Use a `POST` request.
    case post
}
