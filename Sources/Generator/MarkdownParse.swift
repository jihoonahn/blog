import Foundation
import Markdown
import Logging

public struct MarkdownParse: Sendable {
    public init() {}
    
    public func parse(from content: String) throws -> Document {
        return Document(parsing: content)
    }
    
    public func extractMetadata(from document: Document) -> PostMetadata {
        var title: String?
        var date: Date?
        var tags: [String]?
        var image: String?
        var description: String?
        
        // H1에서 제목 추출
        for child in document.children {
            if let heading = child as? Heading, heading.level == 1 {
                title = heading.plainText
                break
            }
        }
        
        return PostMetadata(
            title: title ?? "Untitled",
            date: date ?? Date(),
            tags: tags ?? [],
            image: image,
            description: description
        )
    }
    
    // 마크다운 컨텐츠에서 프론트매터 파싱
    public func extractMetadata(from content: String) -> PostMetadata {
        var title: String?
        var date: Date = Date()
        var tags: [String] = []
        var image: String?
        var description: String?
        
        // YAML 프론트매터 파싱 (---)
        if content.hasPrefix("---") {
            let lines = content.components(separatedBy: .newlines)
            var inFrontMatter = false
            var frontMatterEndIndex = 0
            
            for (index, line) in lines.enumerated() {
                if index == 0 && line == "---" {
                    inFrontMatter = true
                    continue
                }
                
                if inFrontMatter && line == "---" {
                    frontMatterEndIndex = index
                    break
                }
                
                if inFrontMatter {
                    let parts = line.components(separatedBy: ":").map { $0.trimmingCharacters(in: .whitespaces) }
                    if parts.count >= 2 {
                        let key = parts[0].lowercased()
                        let value = parts[1...].joined(separator: ":").trimmingCharacters(in: .whitespaces)
                        
                        switch key {
                        case "title":
                            title = value.trimmingCharacters(in: CharacterSet(charactersIn: "\"'"))
                        case "date":
                            if let parsedDate = parseDate(value) {
                                date = parsedDate
                            }
                        case "tags":
                            // tags: [swift, blog] 또는 tags: swift, blog 형식 지원
                            let cleanedValue = value.trimmingCharacters(in: CharacterSet(charactersIn: "[]\"'"))
                            tags = cleanedValue.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                        case "image":
                            image = value.trimmingCharacters(in: CharacterSet(charactersIn: "\"'"))
                        case "description":
                            description = value.trimmingCharacters(in: CharacterSet(charactersIn: "\"'"))
                        default:
                            break
                        }
                    }
                }
            }
        }
        
        // 프론트매터가 없으면 H1에서 제목 추출
        if title == nil {
            let document = Document(parsing: content)
            for child in document.children {
                if let heading = child as? Heading, heading.level == 1 {
                    title = heading.plainText
                    break
                }
            }
        }
        
        return PostMetadata(
            title: title ?? "Untitled",
            date: date,
            tags: tags,
            image: image,
            description: description
        )
    }
    
    private func parseDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        // 다양한 날짜 형식 지원
        let formats = [
            "yyyy-MM-dd",
            "yyyy/MM/dd",
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss"
        ]
        
        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: dateString.trimmingCharacters(in: CharacterSet(charactersIn: "\"'"))) {
                return date
            }
        }
        
        return nil
    }
}

public struct PostMetadata: Sendable {
    public let title: String
    public let date: Date
    public let tags: [String]
    public let image: String?
    public let description: String?
    
    public init(title: String, date: Date, tags: [String], image: String? = nil, description: String? = nil) {
        self.title = title
        self.date = date
        self.tags = tags
        self.image = image
        self.description = description
    }
}

extension Heading {
    var plainText: String {
        var text = ""
        for child in children {
            if let textElement = child as? Text {
                text += textElement.string
            }
        }
        return text
    }
}
