// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swan-xcodebuild",
    products: [
        .executable(name: "swan-xcodebuild", targets: ["swan-xcodebuild"])
    ],
    dependencies: [
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "swan-xcodebuild",
            dependencies: ["ArgumentParser", "ColorizeSwift"]),
        .testTarget(
            name: "swan-xcodebuildTests",
            dependencies: ["swan-xcodebuild"]),
    ]
)
