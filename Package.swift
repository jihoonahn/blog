// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Blog",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "Blog",
            targets: ["Blog"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/JohnSundell/SplashPublishPlugin", from: "0.2.0")
    ],
    targets: [
        .executableTarget(
            name: "Blog",
            dependencies: ["Publish", "SplashPublishPlugin"]
        )
    ]
)
