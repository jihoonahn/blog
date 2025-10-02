import File

public struct Favicon {
    /// The favicon's absolute path.
    public var path: Path
    /// The MIME type of the image.
    public var type: String

    /// Initialize a new instance of this type
    /// - Parameter path: The favicon's absolute path (default: "images/favicon.png").
    /// - Parameter type: The MIME type of the image (default: "image/png").
    public init(path: Path = .defaultFavicon, type: String = "/image/png") {
        self.path = path
        self.type = type
    }
}
