// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NoVaporApp",
    platforms: [
        .macOS(.v13)
    ],
    
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NoVaporApp",
            targets: ["NoVaporApp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.83.1"),
        .package(url: "https://github.com/orlandos-nl/MongoKitten.git", exact: "7.7.1"),
        .package(url: "https://github.com/ultim8p/NoCrypto.git", from: "0.0.1"),
        .package(url: "https://github.com/ultim8p/NoVaporError.git", from: "0.0.1"),
        .package(url: "https://github.com/ultim8p/NoMongo.git", from: "0.0.1"),
        .package(url: "https://github.com/ultim8p/NoServerAuth.git", from: "0.0.1"),
        .package(url: "https://github.com/ultim8p/NoVaporAPI.git", from: "0.0.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NoVaporApp", 
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "MongoKitten", package: "MongoKitten"),
                .product(name: "NoCrypto", package: "NoCrypto"),
                .product(name: "NoServerAuth", package: "NoServerAuth"),
                .product(name: "NoMongo", package: "NoMongo"),
                .product(name: "NoVaporAPI", package: "NoVaporAPI"),
                .product(name: "NoVaporError", package: "NoVaporError"),
            ]),
        .testTarget(
            name: "NoVaporAppTests",
            dependencies: ["NoVaporApp"]),
    ]
)
