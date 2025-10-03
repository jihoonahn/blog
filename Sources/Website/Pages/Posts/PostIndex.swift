import Foundation
import Web
import Generator

@HTMLBuilder
func postIndex(posts: [Post], page: Int = 1, postsPerPage: Int = 10) -> HTML {
    let metadata = SiteMetaData(title: "Blog")
    let sortedPosts = posts.sorted { $0.metadata.date > $1.metadata.date }
    let paginatedPosts = PaginatedPosts(posts: sortedPosts, currentPage: page, postsPerPage: postsPerPage)

    Layout(
        metadata: metadata
    ) {
        Main {
            Div {
                Div {
                    List(paginatedPosts.posts) { post in
                        ListItem {
                            Link(url: "/posts/\(post.slug)/") {
                                PostCard(post: post)
                            }
                            .class("block")
                        }
                    }
                    .class("grid grid-cols-1 gap-6")
                    
                    // Pagination
                    if paginatedPosts.totalPages > 1 {
                        Div {
                            // Previous button
                            if paginatedPosts.hasPreviousPage {
                                let previousURL = paginatedPosts.previousPageNumber == 1 ? "/posts/" : "/posts/page/\(paginatedPosts.previousPageNumber!)"
                                Link(url: previousURL) {
                                    Span {
                                        Text("←")
                                    }
                                }
                                .class("px-3 py-2 sm:px-4 bg-neutral-800 text-white rounded-lg hover:bg-neutral-700 transition-colors text-sm sm:text-base")
                            } else {
                                Span {
                                    Text("←")
                                }
                                .class("px-3 py-2 sm:px-4 bg-neutral-600 text-neutral-200 rounded-lg cursor-not-allowed text-sm sm:text-base")
                            }
                            
                            Div {
                                Div {
                                    Span {
                                        Text("\(paginatedPosts.currentPage)")
                                    }
                                    .class("bg-neutral-700 text-white font-semibold")
                                    Span {
                                        Text(" / ")
                                    }
                                    .class("text-neutral-500")
                                    Span {
                                        Text("\(paginatedPosts.totalPages)")
                                    }
                                    .class("text-neutral-500")
                                }
                                .class("sm:hidden px-3 py-2 bg-neutral-700 rounded-lg")
                                
                                Div {
                                    let visiblePages = calculateVisiblePages(current: paginatedPosts.currentPage, total: paginatedPosts.totalPages, maxVisible: 5)
                                    for pageNumber in visiblePages {
                                        if pageNumber == paginatedPosts.currentPage {
                                            Span {
                                                Text("\(pageNumber)")
                                            }
                                            .class("px-3 py-2 bg-neutral-700 text-white rounded-lg text-sm")
                                        } else {
                                            let pageURL = pageNumber == 1 ? "/posts/" : "/posts/page/\(pageNumber)"
                                            Link(url: pageURL) {
                                                Span {
                                                    Text("\(pageNumber)")
                                                }
                                            }
                                            .class("px-3 py-2 bg-neutral-800 text-white rounded-lg hover:bg-neutral-700 transition-colors text-sm")
                                        }
                                    }
                                }
                                .class("hidden sm:flex items-center gap-1")
                            }
                            
                            // Next button
                            if paginatedPosts.hasNextPage {
                                Link(url: "/posts/page/\(paginatedPosts.nextPageNumber!)") {
                                    Span {
                                        Text("→")
                                    }
                                }
                                .class("px-3 py-2 sm:px-4 bg-neutral-800 text-white rounded-lg hover:bg-neutral-700 transition-colors text-sm sm:text-base")
                            } else {
                                Span {
                                    Text("→")
                                }
                                .class("px-3 py-2 sm:px-4 bg-neutral-600 text-neutral-200 rounded-lg cursor-not-allowed text-sm sm:text-base")
                            }
                        }
                        .class("flex justify-center items-center gap-2 sm:gap-3 mt-8")
                    }
                }
            }
            .class("max-w-2xl mx-auto px-6 pb-24 pt-32")
        }
        .class("min-h-screen")
    }
}

private func calculateVisiblePages(current: Int, total: Int, maxVisible: Int) -> [Int] {
    var pages: [Int] = []
    
    if total <= maxVisible {
        pages = Array(1...total)
    } else {
        let halfVisible = maxVisible / 2
        
        if current <= halfVisible {
            pages = Array(1...maxVisible)
        } else if current >= total - halfVisible {
            pages = Array((total - maxVisible + 1)...total)
        } else {
            let start = current - halfVisible
            let end = current + halfVisible
            pages = Array(start...end)
        }
    }
    
    return pages
}
