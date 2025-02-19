// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let sharedError = "SharedError"
let package = Package(
    name: "NetworkManager",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"]),
    ],
    dependencies: [
        .package(name: sharedError, path: "../\(sharedError)"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NetworkManager",
            dependencies: [
            .product(name: sharedError, package: sharedError),
            ]
        ),
        .testTarget(
            name: "NetworkManagerTests",
            dependencies: ["NetworkManager"]
        ),
    ]
)
