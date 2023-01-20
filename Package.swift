// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VivUIExtensions",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VivUIExtensions",
            targets: ["VivUIExtensions"]),
    ],
    targets: [
        .target(
            name: "VivUIExtensions",
            dependencies: []),
        .testTarget(
            name: "VivUIExtensionsTests",
            dependencies: ["VivUIExtensions"]),
    ]
)
