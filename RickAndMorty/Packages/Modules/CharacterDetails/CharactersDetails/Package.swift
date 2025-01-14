// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let characterDetailsInterface = "CharacterDetailsInterface"

let package = Package(
    name: "CharactersDetails",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CharactersDetails",
            targets: ["CharactersDetails"]),
    ],
    dependencies: [
        .package(name: characterDetailsInterface, path: "../\(characterDetailsInterface)")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CharactersDetails",
        dependencies: [
        .product(name: characterDetailsInterface, package: characterDetailsInterface),
        ]),
        .testTarget(
            name: "CharactersDetailsTests",
            dependencies: ["CharactersDetails"]
        ),
    ]
)
