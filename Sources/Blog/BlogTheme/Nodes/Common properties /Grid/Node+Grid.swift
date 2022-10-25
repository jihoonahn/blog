import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func grid(_ nodes: Node...) -> Node {
        return .div(
            .class("home-template has-cover"),
            .div(
                .class("viewport"),
                .group(nodes)
            ),
            .script(
                .src("/js/Channel_talk/Channel_talk.js"),
                .defer()
            )
        )
    }
}
