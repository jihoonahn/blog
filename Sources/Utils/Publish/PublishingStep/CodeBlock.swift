extension PublishingStep where Site == Blog {
    static func codeBlock(_ classPrefix: String = "") -> Self {
        step(named: "CodeBlock") { step in
            step.markdownParser.addModifier(
                .codeBlock(HTMLOutputFormat(classPrefix: classPrefix))
            )
        }
    }
}

extension Modifier {
    static func codeBlock(_ format: HTMLOutputFormat = HTMLOutputFormat()) -> Self {
        let highlighter = SyntaxHighlighter(format: format)

        return Modifier(target: .codeBlocks) { html, markdown in
            var markdown = markdown.dropFirst("```".count)

            guard !markdown.hasPrefix("no-highlight") else {
                return html
            }

            markdown = markdown
                .drop(while: { !$0.isNewline })
                .dropFirst()
                .dropLast("\n```".count)

            let highlighted = highlighter.highlight(String(markdown))
            return "<pre><code>" + highlighted + "\n</code></pre>"
        }
    }
}
