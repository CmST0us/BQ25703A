// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BQ25703A",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BQ25703A",
            targets: ["BQ25703A"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-mmio.git", from: "0.0.2"),
        .package(url: "https://github.com/rensbreur/SwiftTUI.git", branch: "main"),
        .package(url: "https://github.com/CmST0us/PeripheryKit.git", branch: "main")
    ],
    targets: [
        .target(
            name: "BQ25703A",
            dependencies: [
                .product(name: "MMIO", package: "swift-mmio"),
            ]),
        
        .executableTarget(
            name: "Tester",
            dependencies: [
                .target(name: "BQ25703A"),
                .product(name: "SwiftTUI", package: "SwiftTUI"),
                .product(name: "PeripheryKit", package: "PeripheryKit")
            ])
    ]
)
