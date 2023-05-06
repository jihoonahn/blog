// swift-tools-version:5.7

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
        .package(url: "https://github.com/JohnSundell/Publish.git", from: "0.9.0"),
        .package(url: "https://github.com/JohnSundell/SplashPublishPlugin.git", from: "0.2.0")
    ],
    targets: [
        .executableTarget(
            name: "Blog",
            dependencies: [
                "Publish",
                "SplashPublishPlugin"
            ]
        )
    ]
)
