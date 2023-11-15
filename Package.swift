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
        .package(url: "https://github.com/JohnSundell/Publish", from: "0.9.0")
    ],
    targets: [
        .executableTarget(
            name: "Blog",
            dependencies: [
                .product(name: "Publish", package: "publish"),
            ],
            path: "Sources",
            exclude: ["Styles/input.css"]
        )
    ]
)
