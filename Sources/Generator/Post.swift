import Foundation
import Markdown

public struct Post: Sendable {
    public let metadata: PostMetadata
    public let content: String
    public let htmlContent: String
    public let slug: String
    
    public init(
        metadata: PostMetadata,
        content: String,
        htmlContent: String,
        slug: String
    ) {
        self.metadata = metadata
        self.content = content
        self.htmlContent = htmlContent
        self.slug = slug
    }
    
    public static func from(file: String, content: String) throws -> Post {
        let parser = MarkdownParse()
        let metadata = parser.extractMetadata(from: content) // 문자열에서 직접 파싱
        
        // 프론트매터 제거한 순수 마크다운 콘텐츠 추출
        let markdownContent = extractMarkdownContent(from: content)
        let document = try parser.parse(from: markdownContent)
        let htmlContent = convertToHTML(document: document)
        
        let slug = file
            .replacingOccurrences(of: ".md", with: "")
            .lowercased()
            .replacingOccurrences(of: " ", with: "-")
        
        return Post(
            metadata: metadata,
            content: content,
            htmlContent: htmlContent,
            slug: slug
        )
    }
    
    private static func extractMarkdownContent(from content: String) -> String {
        // 프론트매터가 있는 경우 제거
        if content.hasPrefix("---") {
            let lines = content.components(separatedBy: .newlines)
            var endIndex = 0
            
            // 첫 번째 --- 찾기
            for (index, line) in lines.enumerated() {
                if index == 0 && line == "---" {
                    continue
                }
                // 두 번째 --- 찾기
                if line == "---" {
                    endIndex = index
                    break
                }
            }
            
            // 프론트매터 이후의 콘텐츠만 반환
            if endIndex > 0 && endIndex + 1 < lines.count {
                return lines[(endIndex + 1)...].joined(separator: "\n")
            }
        }
        
        // 프론트매터가 없으면 원본 반환
        return content
    }
    
    private static func convertToHTML(document: Document) -> String {
        var html = ""
        
        for child in document.children {
            if let heading = child as? Heading {
                html += "<h\(heading.level)>\(heading.plainText)</h\(heading.level)>\n"
            } else if let paragraph = child as? Paragraph {
                html += "<p>\(extractText(from: paragraph))</p>\n"
            } else if let codeBlock = child as? CodeBlock {
                let language = codeBlock.language ?? ""
                let highlightedCode = highlightCode(codeBlock.code, language: language)
                html += "<pre><code class=\"language-\(language)\">\(highlightedCode)</code></pre>\n"
            }
        }
        
        return html
    }
    
    private static func extractText(from paragraph: Paragraph) -> String {
        var text = ""
        for child in paragraph.children {
            if let textElement = child as? Text {
                text += textElement.string
            } else if let strong = child as? Strong {
                text += "<strong>\(extractTextFromInline(strong))</strong>"
            } else if let emphasis = child as? Emphasis {
                text += "<em>\(extractTextFromInline(emphasis))</em>"
            } else if let code = child as? InlineCode {
                text += "<code>\(code.code)</code>"
            }
        }
        return text
    }
    
    private static func extractTextFromInline(_ inline: InlineMarkup) -> String {
        var text = ""
        for child in inline.children {
            if let textElement = child as? Text {
                text += textElement.string
            }
        }
        return text
    }
    
    private static func highlightCode(_ code: String, language: String) -> String {
        switch language.lowercased() {
        case "swift":
            return highlightSwift(code)
        case "javascript", "js":
            return highlightJavaScript(code)
        case "python", "py":
            return highlightPython(code)
        case "html":
            return highlightHTML(code)
        case "css":
            return highlightCSS(code)
        case "json":
            return highlightJSON(code)
        case "bash", "shell", "sh":
            return highlightBash(code)
        case "yaml", "yml":
            return highlightYAML(code)
        default:
            return escapeHTML(code)
        }
    }
    
    private static func escapeHTML(_ text: String) -> String {
        return text
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&#39;")
    }
    
    private static func highlightSwift(_ code: String) -> String {
        let swiftKeywords = [
            "func", "class", "struct", "enum", "protocol", "extension", "import", "let", "var",
            "if", "else", "for", "while", "do", "try", "catch", "throw", "return", "break", "continue",
            "public", "private", "internal", "static", "final", "override", "required", "convenience",
            "init", "deinit", "self", "super", "nil", "true", "false", "as", "is", "in", "where",
            "guard", "defer", "repeat", "switch", "case", "default", "fallthrough", "async", "await",
            "throws", "rethrows", "mutating", "nonmutating", "lazy", "weak", "unowned", "optional",
            "some", "any", "anyobject", "sendable", "mainactor", "actor", "isolated", "nonisolated"
        ]
        
        return highlightWithKeywords(code, keywords: swiftKeywords, stringDelimiters: ["\"", "'"], commentPrefix: "//")
    }
    
    private static func highlightJavaScript(_ code: String) -> String {
        let jsKeywords = [
            "function", "class", "const", "let", "var", "if", "else", "for", "while", "do", "try", "catch",
            "throw", "return", "break", "continue", "switch", "case", "default", "new", "this", "super",
            "import", "export", "from", "as", "async", "await", "typeof", "instanceof", "in", "of",
            "true", "false", "null", "undefined", "NaN", "Infinity", "console", "window", "document"
        ]
        
        return highlightWithKeywords(code, keywords: jsKeywords, stringDelimiters: ["\"", "'", "`"], commentPrefix: "//")
    }
    
    private static func highlightPython(_ code: String) -> String {
        let pythonKeywords = [
            "def", "class", "if", "elif", "else", "for", "while", "try", "except", "finally", "with",
            "import", "from", "as", "return", "yield", "break", "continue", "pass", "raise", "assert",
            "lambda", "and", "or", "not", "in", "is", "True", "False", "None", "self", "super",
            "async", "await", "global", "nonlocal", "del"
        ]
        
        return highlightWithKeywords(code, keywords: pythonKeywords, stringDelimiters: ["\"", "'", "\"\"\"", "'''"], commentPrefix: "#")
    }
    
    private static func highlightHTML(_ code: String) -> String {
        var result = code
        
        // HTML 태그 하이라이트
        result = result.replacingOccurrences(
            of: "<([^>]+)>",
            with: "<span class=\"token tag\">&lt;$1&gt;</span>",
            options: .regularExpression
        )
        
        // 속성 하이라이트
        result = result.replacingOccurrences(
            of: "\\s([a-zA-Z-]+)=",
            with: " <span class=\"token attr-name\">$1</span>=",
            options: .regularExpression
        )
        
        // 속성 값 하이라이트
        result = result.replacingOccurrences(
            of: "=\"([^\"]+)\"",
            with: "=\"<span class=\"token attr-value\">$1</span>\"",
            options: .regularExpression
        )
        
        return escapeHTML(result)
    }
    
    private static func highlightCSS(_ code: String) -> String {
        var result = code
        
        // CSS 선택자
        result = result.replacingOccurrences(
            of: "^([^{]+)\\{",
            with: "<span class=\"token selector\">$1</span>{",
            options: .regularExpression
        )
        
        // CSS 속성
        result = result.replacingOccurrences(
            of: "\\s([a-zA-Z-]+):",
            with: " <span class=\"token property\">$1</span>:",
            options: .regularExpression
        )
        
        // CSS 값
        result = result.replacingOccurrences(
            of: ":\\s*([^;]+);",
            with: ": <span class=\"token value\">$1</span>;",
            options: .regularExpression
        )
        
        return escapeHTML(result)
    }
    
    private static func highlightJSON(_ code: String) -> String {
        var result = code
        
        // JSON 키
        result = result.replacingOccurrences(
            of: "\"([^\"]+)\":",
            with: "\"<span class=\"token property\">$1</span>\":",
            options: .regularExpression
        )
        
        // JSON 문자열 값
        result = result.replacingOccurrences(
            of: ":\\s*\"([^\"]+)\"",
            with: ": \"<span class=\"token string\">$1</span>\"",
            options: .regularExpression
        )
        
        // JSON 숫자
        result = result.replacingOccurrences(
            of: ":\\s*(\\d+(?:\\.\\d+)?)",
            with: ": <span class=\"token number\">$1</span>",
            options: .regularExpression
        )
        
        // JSON 불린
        result = result.replacingOccurrences(
            of: ":\\s*(true|false)",
            with: ": <span class=\"token boolean\">$1</span>",
            options: .regularExpression
        )
        
        return escapeHTML(result)
    }
    
    private static func highlightBash(_ code: String) -> String {
        let bashKeywords = [
            "if", "then", "else", "elif", "fi", "for", "while", "do", "done", "case", "esac",
            "function", "return", "break", "continue", "exit", "echo", "printf", "read", "cd",
            "ls", "pwd", "mkdir", "rm", "cp", "mv", "chmod", "chown", "grep", "sed", "awk",
            "export", "source", "alias", "unalias", "type", "which", "whereis", "man", "help"
        ]
        
        return highlightWithKeywords(code, keywords: bashKeywords, stringDelimiters: ["\"", "'"], commentPrefix: "#")
    }
    
    private static func highlightYAML(_ code: String) -> String {
        var result = code
        
        // YAML 키
        result = result.replacingOccurrences(
            of: "^([^:]+):",
            with: "<span class=\"token property\">$1</span>:",
            options: .regularExpression
        )
        
        // YAML 문자열 값
        result = result.replacingOccurrences(
            of: ":\\s*\"([^\"]+)\"",
            with: ": \"<span class=\"token string\">$1</span>\"",
            options: .regularExpression
        )
        
        // YAML 숫자
        result = result.replacingOccurrences(
            of: ":\\s*(\\d+(?:\\.\\d+)?)",
            with: ": <span class=\"token number\">$1</span>",
            options: .regularExpression
        )
        
        // YAML 불린
        result = result.replacingOccurrences(
            of: ":\\s*(true|false|yes|no)",
            with: ": <span class=\"token boolean\">$1</span>",
            options: .regularExpression
        )
        
        return escapeHTML(result)
    }
    
    private static func highlightWithKeywords(_ code: String, keywords: [String], stringDelimiters: [String], commentPrefix: String) -> String {
        let escapedCode = escapeHTML(code)
        let lines = escapedCode.components(separatedBy: .newlines)
        var processedLines: [String] = []
        
        for line in lines {
            var processedLine = line
            
            // 주석 처리 (먼저 처리)
            if let commentRange = processedLine.range(of: commentPrefix) {
                let beforeComment = String(processedLine[..<commentRange.lowerBound])
                let comment = String(processedLine[commentRange.lowerBound...])
                processedLine = beforeComment + "<span class=\"token comment\">\(comment)</span>"
            }
            
            // 문자열 처리 (주석이 아닌 부분만)
            if !processedLine.contains("<span class=\"token comment\">") {
                for delimiter in stringDelimiters {
                    processedLine = processedLine.replacingOccurrences(
                        of: "\(delimiter)([^\(delimiter)]*)\(delimiter)",
                        with: "\(delimiter)<span class=\"token string\">$1</span>\(delimiter)",
                        options: .regularExpression
                    )
                }
            }
            
            // 키워드 처리 (문자열과 주석이 아닌 부분만)
            if !processedLine.contains("<span class=\"token comment\">") && !processedLine.contains("<span class=\"token string\">") {
                for keyword in keywords {
                    let pattern = "\\b\(keyword)\\b"
                    processedLine = processedLine.replacingOccurrences(
                        of: pattern,
                        with: "<span class=\"token keyword\">\(keyword)</span>",
                        options: .regularExpression
                    )
                }
            }
            
            processedLines.append(processedLine)
        }
        
        return processedLines.joined(separator: "\n")
    }
}
