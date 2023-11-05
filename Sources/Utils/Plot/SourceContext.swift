import Plot

public extension Node where Context: HTMLSourceContext {
    static func crossorigin(_ text: String) -> Node {
        .attribute(named: "crossorigin",value: text)
    }
    static func issue_term(_ text: String) -> Node {
        .attribute(named: "issue-term",value: text)
    }
    static func label(_ text: String) -> Node {
        .attribute(named: "label",value: text)
    }
    static func repo(_ text: String) -> Node {
        .attribute(named: "repo",value: text)
    }
    static func theme(_ text: String) -> Node {
        .attribute(named: "theme",value: text)
    }
    static func type(_ type: String) -> Node {
        .attribute(named: "type",value: type)
    }
}
