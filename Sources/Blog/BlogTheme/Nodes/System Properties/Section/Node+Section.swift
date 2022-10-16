import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func section() -> Node {
        return .main(
            .class("")
        )
    }
}
