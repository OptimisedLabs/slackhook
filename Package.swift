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
    ],
    targets: [
        .target(
            name: "SlackHook",
            dependencies: []),
        .testTarget(
            name: "SlackHookTests",
            dependencies: ["SlackHook"]),
    ]
)
