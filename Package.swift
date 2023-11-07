// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "blog",
    platforms: [.macOS(.v13)],
    products: [
        .executable(
            name: "Blog",
            targets: ["Blog"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Publish", from: "0.9.0"),
        .package(url: "https://github.com/JohnSundell/SplashPublishPlugin", from: "0.2.0"),
        .package(url: "https://github.com/tuist/SwiftyTailwind", from: "0.4.0")
    ],
    targets: [
        .executableTarget(
            name: "Blog",
            dependencies: [
                .product(name: "SplashPublishPlugin", package: "SplashPublishPlugin"),
                .product(name: "Publish", package: "publish"),
                .product(name: "SwiftyTailwind", package: "SwiftyTailwind")
            ],
            path: "Sources"
        )
    ]
)
