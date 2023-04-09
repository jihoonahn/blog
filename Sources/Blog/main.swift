import Foundation
import Publish
import SplashPublishPlugin
import Plot

try Blog().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .optional(.copyResources()),
    .addMarkdownFiles(),
    .group([.generatePaginatedPages()]),
    .generateHTML(withTheme: .blog),
    .generateRSSFeed(including: [.blog]),
    .generateSiteMap(),
    .move404FileForBlog(),
    .deploy(using: .gitHub("Jihoonahn/Blog", useSSH: false))
])
