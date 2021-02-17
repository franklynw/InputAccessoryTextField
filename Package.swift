// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InputAccessoryTextField",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "InputAccessoryTextField",
            targets: ["InputAccessoryTextField"]),
    ],
    dependencies: [
        .package(name: "FWCommonProtocols", url: "https://github.com/franklynw/FWCommonProtocols.git", .upToNextMajor(from: "1.0.0")),
        .package(name: "ButtonConfig", url: "https://github.com/franklynw/ButtonConfig.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "InputAccessoryTextField",
            dependencies: ["FWCommonProtocols", "ButtonConfig"]),
        .testTarget(
            name: "InputAccessoryTextFieldTests",
            dependencies: ["InputAccessoryTextField"]),
    ]
)
