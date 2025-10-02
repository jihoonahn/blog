import Foundation
import Web
import Generator

struct PostLayout: HTMLConvertable {
    let post: Post
    let allPosts: [Post]
    
    var metadata: SiteMetaData {
        SiteMetaData(
            title: post.metadata.title,
            description: String(post.content.prefix(150)),
        )
    }

    func build() -> HTML {
        Layout(metadata: metadata) {
            Main {
                Div {
                    Div {
                        Div {
                            Div {
                                Link(url: "/posts") {
                                    BackIcon()
                                }
                                .class("flex items-center justify-center hover:bg-neutral-800 hover:text-neutral-400 rounded-full transition-colors duration-200 text-neutral-600 w-12 h-12")
                            }
                            .class("bg-black rounded-full border border-neutral-800 p-2")
                        }
                        .class("flex gap-3 mb-8")
                    }
                    .class("px-6 mx-auto max-w-2xl")
                    Div {
                        Div {
                            Time {
                                Text(post.metadata.date.formatDate())
                            }
                            .class("font-regular text-gray-500 text-sm")
                        }
                        .class("my-5 text-center")
                        H1(post.metadata.title)
                        .class("text-3xl font-bold mb-4 text-center")
                        Paragraph(post.metadata.description ?? "")
                            .class("text-base leading-relaxed text-center")
                    }
                    .class("max-w-2xl mx-auto px-6")
                    if let image = post.metadata.image {
                        Div {
                            Figure {
                                Image(image)
                                    .class("p-0 w-full h-full object-cover")
                            }
                            .class("rounded-xl overflow-hidden")
                        }
                        .class("max-w-4xl mx-auto p-6")
                    }
                    Div {
                        Node<Any>.raw(post.htmlContent)
                    }
                    .class("markdown-content mx-auto max-w-2xl px-6 text-left")
                    
                    // Post Navigation
                    Div {
                        PostNavigation(currentPost: post, allPosts: allPosts)
                    }
                    .class("max-w-2xl mx-auto px-6")
                }
                Script(
                    Text("""
                    document.addEventListener('DOMContentLoaded', function() {
                        const codeBlocks = document.querySelectorAll('.markdown-content pre');
                        
                        codeBlocks.forEach(function(pre) {
                            const copyButton = document.createElement('button');
                            copyButton.textContent = 'Copy';
                            copyButton.className = 'copy-code-button';
                            
                            copyButton.addEventListener('click', function() {
                                const codeElement = pre.querySelector('code');
                                const codeText = codeElement ? codeElement.textContent : pre.textContent;
                                
                                navigator.clipboard.writeText(codeText).then(function() {
                                    copyButton.textContent = 'Copied!';
                                    setTimeout(function() {
                                        copyButton.textContent = 'Copy';
                                    }, 1500);
                                }).catch(function() {
                                    const textArea = document.createElement('textarea');
                                    textArea.value = codeText;
                                    document.body.appendChild(textArea);
                                    textArea.select();
                                    document.execCommand('copy');
                                    document.body.removeChild(textArea);
                                    
                                    copyButton.textContent = 'Copied!';
                                    setTimeout(function() {
                                        copyButton.textContent = 'Copy';
                                    }, 1500);
                                });
                            });
                            
                            pre.appendChild(copyButton);
                        });
                    });
                    """)
                )
            }
            .class("min-h-screen pb-24 pt-32")
        }
        .build()
    }
}
