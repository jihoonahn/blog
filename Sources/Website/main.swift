import Foundation
import Generator
import Web
import Command

let arguments = CommandLine.arguments

var content = Content { post, allPosts in
    PostLayout(post: post, allPosts: allPosts)
        .build()
}

let contentPages = try content.load()
let allPosts = content.posts

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
    ),
    Page(
        name: "Posts",
        path: "posts",
        html: postIndex(posts: allPosts),
        children: contentPages
    ),
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
        print("📍 Open http://localhost:8000 in your browser")
        print("⌨️  Press Ctrl+C to stop the server\n")
        

        let python = Alias(executableURL: "/usr/bin/python3")
        python.run(["-m", "http.server", "8000", "--directory", "dist"])
        
        print("✅ Preview server is running at http://localhost:8000")
        print("   Serving files from: dist/\n")
    } else {
        print("\n💡 Tip: Run 'swift run Website preview' to start a local server")
    }
    
} catch {
    print("❌ Error: \(error.localizedDescription)")
    exit(1)
}
