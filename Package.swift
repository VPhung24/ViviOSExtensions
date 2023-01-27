// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViviOSExtensions",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VivUIKitExtensions",
            targets: ["VivUIKitExtensions"]),
        .library(
            name: "VivNetworkExtensions",
            targets: ["VivNetworkExtensions"]),
    ],
    targets: [
        .target(
            name: "VivUIKitExtensions",
            dependencies: []),
        .target(
            name: "VivNetworkExtensions",
            dependencies: []),
        .testTarget(
            name: "VivUIKitExtensionsTests",
            dependencies: ["VivUIKitExtensions"]),
        .testTarget(
            name: "VivNetworkExtensionsTests",
            dependencies: ["VivNetworkExtensions"]),
    ]
)
