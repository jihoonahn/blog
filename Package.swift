// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "swift-blog",
    platforms: [.macOS(.v13)],
    products: [
        .executable(
            name: "Blog",
            targets: ["Blog"]
        ),
        .library(
            name: "App",
            targets: ["App"]
        ),
        .library(
            name: "Domain",
            targets: ["Domain"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/supabase-community/supabase-swift", from: "2.33.1"),
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.28.0")
    ],
    targets: [
        .executableTarget(
            name: "Blog",
            dependencies: [
                .target(name: "App"),
                .target(name: "Domain")
            ]
        ),
               .target(
                   name: "App",
                   dependencies: [
                       .target(name: "Domain"),
                       .product(name: "AsyncHTTPClient", package: "async-http-client")
                   ],
                   path: "Sources/App"
               ),
        .target(
            name: "Domain",
            dependencies: [
                .product(name: "Supabase", package: "supabase-swift"),
            ],
            path: "Sources/Domain"
        )
    ]
)
