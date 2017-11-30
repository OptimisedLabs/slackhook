// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SlackHook",
    products: [
        .library(
            name: "SlackHook",
            targets: ["SlackHook"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/vapor/engine.git",
            .upToNextMajor(from: "2.2.1")
        )
    ],
    targets: [
        .target(
            name: "SlackHook",
            dependencies: ["HTTP"]),
        .testTarget(
            name: "SlackHookTests",
            dependencies: ["SlackHook"]),
    ]
)
