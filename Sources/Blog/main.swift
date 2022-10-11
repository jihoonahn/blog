import Foundation
import Publish
import SplashPublishPlugin
import Plot

try Blog().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .blog),
    .generateRSSFeed(including: [.posts]),
    .generateSiteMap(),
    .deploy(using: .gitHub("JiHoonAHN/JiHoonAHN.github.io"))
])
