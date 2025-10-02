import Foundation
import Web
import Generator

struct PostNavigation: Component {
    let currentPost: Post
    let allPosts: [Post]
    
    init(currentPost: Post, allPosts: [Post]) {
        self.currentPost = currentPost
        self.allPosts = allPosts
    }
    
    var body: Component {
        Div {
            if let previousPost = getPreviousPost() {
                Div {
                    Link(url: "/posts/\(previousPost.slug)") {
                        Div {
                            Paragraph("Preview Post")
                                .class("text-sm text-gray-500 mb-2")
                            H3(previousPost.metadata.title)
                                .class("text-2xl font-semibold text-neutral-300 hover:text-white transition-colors")
                        }
                        .class("p-4 w-full h-full rounded-lg bg-black border border-neutral-800 hover:border-neutral-600 hover:shadow-sm transition-all duration-200 cursor-pointer")
                    }
                    .class("flex cursor-pointer items-center w-full h-full")
                }
                .class("min-w-0 flex-1")
            }
            if let nextPost = getNextPost() {
                Div {
                    Link(url: "/posts/\(nextPost.slug)") {
                        Div {
                            Paragraph("Next Post")
                                .class("text-sm text-gray-500 mb-2 text-right")
                            H3(nextPost.metadata.title)
                                .class("text-2xl font-semibold text-neutral-300 hover:text-white transition-colors")
                        }
                        .class("p-4 w-full h-full rounded-lg bg-black border border-neutral-800 hover:border-neutral-600 hover:shadow-sm transition-all duration-200 cursor-pointer text-right")
                    }
                    .class("flex cursor-pointer items-center w-full h-full")
                }
                .class("min-w-0 flex-1")
            }
        }
        .class("flex flex-col gap-4 px-4 mt-11 mb-4 max-w-3xl mx-auto md:flex-row md:px-0 md:gap-8")
    }
    
    private func getPreviousPost() -> Post? {
        let sortedPosts = allPosts.sorted { $0.metadata.date > $1.metadata.date }
        guard let currentIndex = sortedPosts.firstIndex(where: { $0.slug == currentPost.slug }) else {
            return nil
        }

        let previousIndex = currentIndex + 1
        return previousIndex < sortedPosts.count ? sortedPosts[previousIndex] : nil
    }
    
    private func getNextPost() -> Post? {
        let sortedPosts = allPosts.sorted { $0.metadata.date > $1.metadata.date }
        guard let currentIndex = sortedPosts.firstIndex(where: { $0.slug == currentPost.slug }) else {
            return nil
        }
        let nextIndex = currentIndex - 1
        return nextIndex >= 0 ? sortedPosts[nextIndex] : nil
    }
}
