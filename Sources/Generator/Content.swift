import Foundation
import File
import Web

public struct Content {
    public let path: String
    public let layout: (@Sendable (Post, [Post]) -> Web.HTML)
    public let postsPerPage: Int
    public private(set) var posts: [Post] = []
    
    public init(path: String = "Sources/Website/Contents", postsPerPage: Int = 10, _ layout: @escaping @Sendable (Post, [Post]) -> Web.HTML) {
        self.path = path
        self.postsPerPage = postsPerPage
        self.layout = layout
    }

    public mutating func load() throws -> [Page] {
        posts = []
        
        // 1단계: 모든 포스트를 먼저 로드
        try loadAllPosts(from: path, relativePath: "")
        
        // 2단계: 모든 포스트가 로드된 후 HTML 생성
        return try generatePages(from: path, relativePath: "")
    }
    
    private mutating func loadAllPosts(from basePath: String, relativePath: String) throws {
        let fullPath = basePath.isEmpty ? relativePath : (relativePath.isEmpty ? basePath : "\(basePath)/\(relativePath)")
        
        let folder = try Folder(path: Path(fullPath))
        
        guard folder.exists() else {
            logger.warning("⚠️  Content path not found: \(fullPath)")
            return
        }
        
        let fileManager = FileManager.default
        let contents = try fileManager.contentsOfDirectory(atPath: fullPath)
        
        for item in contents where !item.hasPrefix(".") {
            let itemPath = "\(fullPath)/\(item)"
            var isDirectory: ObjCBool = false
            fileManager.fileExists(atPath: itemPath, isDirectory: &isDirectory)
            
            if isDirectory.boolValue {
                try loadAllPosts(from: fullPath, relativePath: item)
            } else if item.hasSuffix(".md") {
                let filePath = Path(itemPath)
                let file = try File(path: filePath)
                let data = try file.read()
                guard let content = String(data: data, encoding: .utf8) else {
                    logger.warning("⚠️  Failed to read file: \(item)")
                    continue
                }

                let post = try Post.from(file: item, content: content)
                posts.append(post)
            }
        }
    }

    private func generatePages(from basePath: String, relativePath: String) throws -> [Page] {
        let fullPath = basePath.isEmpty ? relativePath : (relativePath.isEmpty ? basePath : "\(basePath)/\(relativePath)")
        
        let folder = try Folder(path: Path(fullPath))
        
        guard folder.exists() else {
            logger.warning("⚠️  Content path not found: \(fullPath)")
            return []
        }
        
        let fileManager = FileManager.default
        let contents = try fileManager.contentsOfDirectory(atPath: fullPath)
        var pages: [Page] = []
        
        for item in contents where !item.hasPrefix(".") {
            let itemPath = "\(fullPath)/\(item)"
            var isDirectory: ObjCBool = false
            fileManager.fileExists(atPath: itemPath, isDirectory: &isDirectory)
            
            if isDirectory.boolValue {
                let subPages = try generatePages(from: fullPath, relativePath: item)
                if !subPages.isEmpty {
                    pages.append(Page(
                        name: item.capitalized,
                        path: item,
                        children: subPages
                    ))
                }
            } else if item.hasSuffix(".md") {
                let filePath = Path(itemPath)
                let file = try File(path: filePath)
                let data = try file.read()
                guard let content = String(data: data, encoding: .utf8) else {
                    logger.warning("⚠️  Failed to read file: \(item)")
                    continue
                }

                let post = try Post.from(file: item, content: content)
                let postHTML = layout(post, posts) // 이제 모든 포스트가 로드된 상태
                
                pages.append(Page(
                    name: post.metadata.title,
                    path: post.slug,
                    html: postHTML,
                    children: [
                        Page(
                            name: "Post",
                            path: "index.html",
                            html: postHTML
                        )
                    ]
                ))
            }
        }

        return pages.sorted { $0.name < $1.name }
    }
    
}
