// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CorePackage",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AppConfigurations",
            targets: ["AppConfigurations"]),
        .library(
            name: "CoreInterface",
            targets: ["CoreInterface"]),
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"]),

    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AppConfigurations",
            dependencies: []
        ),
        .target(
            name: "CoreInterface",
            dependencies: []
        ),
        .target(
            name: "NetworkManager",
            dependencies: []
        ),
        .testTarget(
            name: "NetworkManagerTests",
            dependencies: ["NetworkManager"]
        ),
    ]
)
