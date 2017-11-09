// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "slack-vapor",
    products: [
        .library(
            name: "slack-vapor",
            targets: ["slack-vapor"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/vapor/engine.git",
            .upToNextMajor(from: "2.2.1")
        )
    ],
    targets: [
        .target(
            name: "slack-vapor",
            dependencies: ["HTTP"]),
        .testTarget(
            name: "slack-vaporTests",
            dependencies: ["slack-vapor"]),
    ]
)
