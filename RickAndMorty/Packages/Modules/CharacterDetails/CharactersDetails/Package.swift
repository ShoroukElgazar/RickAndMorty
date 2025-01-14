// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
private let characterDetailsInterface = "CharacterDetailsInterface"
private let commonUI = "CommonUI"
private let utilities = "Utilities"
private let commonModels = "CommonModels"

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
        .package(name: characterDetailsInterface, path: "../\(characterDetailsInterface)"),
        .package(name: commonUI, path: "../../\(commonUI)"),
        .package(name: utilities, path: "../../\(utilities)"),
        .package(name: commonModels, path: "../../\(commonModels)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CharactersDetails",
        dependencies: [
        .product(name: characterDetailsInterface, package: characterDetailsInterface),
        .product(name: commonUI, package: commonUI),
        .product(name: utilities, package: utilities),
        .product(name: commonModels, package: commonModels)
        ]),
        .testTarget(
            name: "CharactersDetailsTests",
            dependencies: ["CharactersDetails"]
        ),
    ]
)
