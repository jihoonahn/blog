// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "blog",
    platforms: [.macOS(.v13)],
    products: [
        .executable(
            name: "App",
            targets: ["App"]
        ),
        .executable(
            name: "Server",
            targets: ["Server"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.117.0"),
        .package(url: "https://github.com/vapor/fluent", from: "4.12.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver", from: "2.11.0"),
        .package(url: "https://github.com/vapor/jwt-kit", from: "5.2.0"),
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.36.0"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "JavaScriptKit", package: "JavaScriptKit"),
                "Shared"
            ]
        ),
        .executableTarget(
            name: "Server",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "JWTKit", package: "jwt-kit"),
                "Shared"
            ],
        ),
        .target(name: "Shared")
    ]
)
