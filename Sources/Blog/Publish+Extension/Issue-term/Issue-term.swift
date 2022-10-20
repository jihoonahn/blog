import Plot

extension Node where Context: HTMLSourceContext {
    static func issue_term(_ text: String) -> Node {
        .attribute(named: "issue-term",value: text)
    }
}
