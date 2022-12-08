import Foundation
import Publish
import SplashPublishPlugin
import Plot

try Blog().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .addMarkdownFiles(),
    .copyResources(),
    .generatePaginatedPages(),
    .generateHTML(withTheme: .blog),
    .generateRSSFeed(including: [.posts]),
    .move404FileForBlog(),
    .generateSiteMap(),
    .deploy(using: .gitHub("JiHoonAHN/Blog"))
])
