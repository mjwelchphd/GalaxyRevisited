// swift-tools-version:5.7

/// File: Package.swift

import PackageDescription

let package = Package(
    name: "GalaxyRevisited",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.54.0"),
        .package(url: "https://github.com/vapor/fluent", from: "4.4.0"),
//        .package(url: "https://github.com/vapor/fluent-sqlite-driver", from: "4.1.0"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0-beta"),
        .package(url: "https://github.com/binarybirds/swift-html", from: "1.6.11")
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Fluent", package: "fluent"),
//            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
            .product(name: "SwiftHtml", package: "swift-html"),
            .product(name: "SwiftSvg", package: "swift-html")
        ]),
        .executableTarget(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor")
        ])
    ]
)
