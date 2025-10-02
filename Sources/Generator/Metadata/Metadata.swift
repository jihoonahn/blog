import Web

public protocol Metadata {
    var title: String { get }
    var description: String { get }
    var url: String { get }
    var favicon: Favicon { get }
}
