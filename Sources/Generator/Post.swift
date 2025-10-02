import Foundation
import Logging

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

public struct Post: Sendable {
    public let metadata: PostMetadata
    public let content: String
    public let htmlContent: String
    public let slug: String
    
    public init(metadata: PostMetadata, content: String, htmlContent: String, slug: String) {
        self.metadata = metadata
        self.content = content
        self.htmlContent = htmlContent
        self.slug = slug
    }
    
    public static func from(file: String, content: String) throws -> Post {
        // 새로운 Markdown Parser 사용
        var parser = MarkdownParser()
        let markdown = parser.parse(content)
        
        // slug 생성
        let slug = file
            .replacingOccurrences(of: ".md", with: "")
            .lowercased()
            .replacingOccurrences(of: " ", with: "-")
        
        // 메타데이터 추출 (새로운 Parser의 metadata 사용)
        let metadata = PostMetadata(
            title: markdown.metadata["title"] ?? "Untitled",
            date: parseDate(from: markdown.metadata["date"]) ?? Date(),
            tags: parseTags(from: markdown.metadata["tags"]),
            image: parseImage(from: markdown.metadata["image"], slug: slug),
            description: markdown.metadata["description"]
        )

        return Post(
            metadata: metadata,
            content: content,
            htmlContent: markdown.html, // 새로운 Parser가 HTML 태그를 직접 처리
            slug: slug
        )
    }
    
    // 날짜 파싱 헬퍼 함수
    private static func parseDate(from dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        // 다양한 날짜 형식 지원
        let formats = [
            "yyyy-MM-dd HH:mm",
            "yyyy-MM-dd H:mm",
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
    
    // 태그 파싱 헬퍼 함수
    private static func parseTags(from tagsString: String?) -> [String] {
        guard let tagsString = tagsString else { return [] }
        
        // tags: [swift, blog] 또는 tags: swift, blog 형식 지원
        let cleanedValue = tagsString.trimmingCharacters(in: CharacterSet(charactersIn: "[]\"'"))
        return cleanedValue.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
    }
    
    // 이미지 파싱 헬퍼 함수
    private static func parseImage(from imageString: String?, slug: String) -> String? {
        guard let imageString = imageString else { return nil }
        
        let trimmedImage = imageString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 외부 URL인 경우 (https:// 또는 http://로 시작)
        if trimmedImage.hasPrefix("https://") || trimmedImage.hasPrefix("http://") {
            return trimmedImage
        }
        
        // 로컬 경로인 경우 /thumbnail/ 경로로 변환
        if trimmedImage.hasPrefix("/") {
            // 이미 절대 경로인 경우 그대로 사용
            return trimmedImage
        } else {
            // 상대 경로인 경우 /thumbnail/ 경로로 변환
            return "/thumbnail/\(trimmedImage)"
        }
    }
}
