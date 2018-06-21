// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SlackHook",
    products: [
        .library(name: "SlackHook", targets: ["SlackHookCore"])
    ],
    dependencies: [
        .package(url: "https://gitlab.com/optimisedlabs/simplerestlayer.git", .upToNextMinor(from: "0.7.0"))
    ],
    targets: [
        .target(
            name: "SlackHook",
            dependencies: ["SlackHookCore"]),
        .target(
            name: "SlackHookCore",
            dependencies: ["SimpleRESTLayer"]),
        .testTarget(
            name: "SlackHookCoreTests",
            dependencies: ["SlackHookCore"]),
    ]
)
