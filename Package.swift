// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Multipart",
    products: [
        .library(name: "Multipart",targets: ["Multipart"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Multipart", dependencies: []),
        .testTarget(name: "MultipartTests", dependencies: ["Multipart"]),
    ]
)
