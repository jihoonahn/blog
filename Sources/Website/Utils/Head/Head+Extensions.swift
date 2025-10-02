import Web
import File
import Generator

extension Node where Context == HTML.HeadContext {
    /// Link the HTML page to an external CSS stylesheet.
    /// - parameter path: The absolute path of the stylesheet to link to.
    static func stylesheet(_ path: Path) -> Node {
        .stylesheet(path.absolutePath.rawValue)
    }

    /// Declare a favicon for the HTML page.
    /// - parameter favicon: The favicon to declare.
    static func favicon(_ favicon: Favicon) -> Node {
        .favicon(favicon.path.absolutePath.rawValue, type: favicon.type)
    }
}
