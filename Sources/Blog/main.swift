import Foundation
import Publish
import SplashPublishPlugin
import Plot

try Blog().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .blog),
    .generateRSSFeed(including: [.blog]),
    .generateSiteMap(),
    .deploy(using: .gitHub("JiHoonAHN/Blog"))
])
