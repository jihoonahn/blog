import Foundation
import Generator
import Web

let arguments = CommandLine.arguments

var content = Content(postsPerPage: postsPerPage) { post, allPosts in
    PostLayout(post: post, allPosts: allPosts)
        .build()
}

let contentPages = try content.load()
let allPosts = content.posts

var paginationPages: [Page] = []
let postsPerPage = 10
let totalPages = max(1, Int(ceil(Double(allPosts.count) / Double(postsPerPage))))

for pageNumber in 1...totalPages {
    let pageHTML = postIndex(posts: allPosts, page: pageNumber, postsPerPage: postsPerPage)
    let pagePath = pageNumber == 1 ? "posts" : "posts/page/\(pageNumber)"
    let pageName = pageNumber == 1 ? "Posts" : "Posts Page \(pageNumber)"
    
    paginationPages.append(Page(
        name: pageName,
        path: pagePath,
        html: pageHTML,
        children: pageNumber == 1 ? contentPages : [
            Page(
                name: pageName,
                path: "index.html",
                html: pageHTML
            )
        ]
    ))
}

let pages = [
    Page(
        name: "Index",
        path: "index.html",
        html: index()
    ),
    Page(
        name: "Page Not Found",
        path: "404.html",
        html: error()
    )
] + paginationPages + [
    Page(
        name: "About",
        path: "about",
        children: [
            Page(
                name: "About Index",
                path: "index.html",
                html: about()
            )
        ]
    )
]

do {
    let generator = Generator(pages: pages, posts: allPosts)
    try generator.generate()
    
    if arguments.contains("preview") || arguments.contains("--preview") {
        print("\n🌐 Starting preview server...")
        
        // 사용 가능한 포트 찾기
        let availablePort = findAvailablePort(startingFrom: 8000)
        print("📍 Open http://localhost:\(availablePort) in your browser")
        print("⌨️  Press Ctrl+C to stop the server\n")
        
        // Python 서버를 백그라운드에서 실행
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/python3")
        process.arguments = ["-m", "http.server", "\(availablePort)", "--directory", "dist"]
        
        do {
            try process.run()
            print("✅ Preview server is running at http://localhost:\(availablePort)")
            print("   Serving files from: dist/\n")
            
            // 서버가 계속 실행되도록 대기
            process.waitUntilExit()
        } catch {
            print("❌ Failed to start preview server: \(error.localizedDescription)")
            print("💡 Make sure Python 3 is installed and accessible")
        }
    } else {
        print("\n💡 Tip: Run 'swift run Website preview' to start a local server")
    }
    
} catch {
    print("❌ Error: \(error.localizedDescription)")
    exit(1)
}

func findAvailablePort(startingFrom port: Int) -> Int {
    for testPort in port...(port + 100) {
        let socket = socket(AF_INET, SOCK_STREAM, 0)
        if socket == -1 { continue }

        var addr = sockaddr_in()
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_port = in_port_t(testPort).bigEndian
        addr.sin_addr.s_addr = in_addr_t(INADDR_LOOPBACK).bigEndian
        
        let result = withUnsafePointer(to: &addr) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                bind(socket, $0, socklen_t(MemoryLayout<sockaddr_in>.size))
            }
        }
        
        close(socket)
        
        if result == 0 {
            return testPort
        }
    }
    return port
}
