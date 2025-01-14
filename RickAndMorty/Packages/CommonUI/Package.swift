// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
private let utilities = "Utilities"

let package = Package(
    name: "CommonUI",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CommonUI",
            targets: ["CommonUI"]),
    ],
    dependencies: [
        .package(name: utilities, path: "../\(utilities)"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CommonUI",
            dependencies: [
            .product(name: utilities, package: utilities)]
        ),
        .testTarget(
            name: "CommonUITests",
            dependencies: ["CommonUI"]
        ),
    ]
)
