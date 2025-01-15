// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let networkManager = "NetworkManager"
private let dependencyContainer = "DependencyContainer"
private let utilities = "Utilities"
private let commonModels = "CommonModels"
private let commonUI = "CommonUI"
private let dependencyConfigurableInterface = "DependencyConfigurableInterface"

let package = Package(
    name: "Characters",
    platforms:  [.iOS(.v15)] ,
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Characters",
            targets: ["Characters"]),
    ],
    dependencies: [
        .package(name: networkManager, path: "../../\(networkManager)"),
        .package(name: dependencyContainer, path: "../../\(dependencyContainer)"),
        .package(name: utilities, path: "../../\(utilities)"),
        .package(name: commonModels, path: "../../\(commonModels)"),
        .package(name: commonUI, path: "../../\(commonUI)"),
        .package(name: dependencyConfigurableInterface, path: "../../\(dependencyConfigurableInterface)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Characters",
            dependencies: [
            .product(name: networkManager, package: networkManager),
            .product(name: dependencyContainer, package: dependencyContainer),
            .product(name: utilities, package: utilities),
            .product(name: commonModels, package: commonModels),
            .product(name: commonUI, package: commonUI),
            .product(name: dependencyConfigurableInterface, package: dependencyConfigurableInterface)
            ]
            ),
        .testTarget(
            name: "CharactersTests",
            dependencies: ["Characters"]
        ),
    ]
)
