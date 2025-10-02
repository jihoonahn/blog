import Foundation

/// Enum that defines various audio formats supported by most browsers.
public enum HTMLAudioFormat: String, Codable, Sendable {
    case mp3 = "mpeg"
    case wav
    case ogg
}
