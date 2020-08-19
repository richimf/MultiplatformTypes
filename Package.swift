// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MultiplatformTypes",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "MultiplatformTypes",
            targets: ["MultiplatformTypes"]),
    ],
    targets: [
        .target(
            name: "MultiplatformTypes",
            dependencies: []),
        .testTarget(
            name: "MultiplatformTypesTests",
            dependencies: ["MultiplatformTypes"]),
    ]
)
