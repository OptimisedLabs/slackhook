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
        .package(url: "https://gitlab.com/optimisedlabs/simplerestlayer.git", .upToNextMinor(from: "0.4.0"))
    ],
    targets: [
        .target(
            name: "SlackHook",
            dependencies: ["SimpleRESTLayer"]),
        .testTarget(
            name: "SlackHookTests",
            dependencies: ["SlackHook"]),
    ]
)
