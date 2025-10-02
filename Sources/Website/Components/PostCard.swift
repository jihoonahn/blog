import Foundation
import Web
import Generator

struct PostCard: Component {
    let post: Post
    
    var body: Component {
        Article {
            if let image = post.metadata.image {
                Div {
                    Image(url: image, description: post.metadata.title)
                        .class("w-full h-48 object-cover")
                }
                .class("w-full h-48 overflow-hidden rounded-t-2xl bg-neutral-800")
            }
            
            Div {
                Div {
                    H2 {
                        Text(post.metadata.title)
                    }
                    .class("text-2xl font-semibold mb-3 text-neutral-100 group-hover:text-neutral-300 transition-colors")
                    
                    Time {
                        Text(post.metadata.date.formatDate())
                    }
                    .class("text-sm text-neutral-500 mb-4 block")
                }
                
                Paragraph(post.metadata.description ?? extractPreview(from: post.content))
                    .class("text-neutral-400 mb-4 line-clamp-3")
                
                if !post.metadata.tags.isEmpty {
                    Div {
                        ComponentGroup(members: post.metadata.tags.map { tag in
                            Span {
                                Text("#\(tag)")
                            }
                            .class("text-xs px-3 py-1 bg-neutral-800/50 text-neutral-400 rounded-full border border-neutral-700")
                        })
                    }
                    .class("flex flex-wrap gap-2")
                }
            }
            .class("p-6")
        }
        .class("block rounded-2xl border border-neutral-800 bg-neutral-900/50 backdrop-blur-sm hover:bg-neutral-800/50 hover:border-neutral-700 transition-all duration-200 group overflow-hidden")
    }

    
    private func extractPreview(from content: String) -> String {
        // 프론트매터 제거
        var cleanContent = content
        if content.hasPrefix("---") {
            let lines = content.components(separatedBy: .newlines)
            var endIndex = 0
            for (index, line) in lines.enumerated() {
                if index > 0 && line == "---" {
                    endIndex = index
                    break
                }
            }
            if endIndex > 0 {
                cleanContent = lines[(endIndex + 1)...].joined(separator: "\n")
            }
        }
        
        // 마크다운 헤더 제거
        let lines = cleanContent.components(separatedBy: .newlines)
        let contentWithoutHeaders = lines
            .filter { !$0.hasPrefix("#") && !$0.trimmingCharacters(in: .whitespaces).isEmpty }
            .joined(separator: " ")
        
        // 첫 150자 추출
        let preview = String(contentWithoutHeaders.prefix(150))
        return preview.trimmingCharacters(in: .whitespaces) + (contentWithoutHeaders.count > 150 ? "..." : "")
    }
}
