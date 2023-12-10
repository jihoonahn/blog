// swift-tools-version:5.7
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
        .package(url: "https://github.com/Johnsundell/Splash", from: "0.16.0")
    ],
    targets: [
        .executableTarget(
            name: "Blog",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                .product(name: "Splash", package: "Splash")
            ],
            path: "Sources",
            exclude: ["Styles/global.css"]
        )
    ]
)
