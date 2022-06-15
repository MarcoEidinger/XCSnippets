// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XCSnippets",
    products: [
        .library(
            name: "XCSnippets",
            targets: ["XCSnippets"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "XCSnippets",
            dependencies: []
        ),
        .testTarget(
            name: "XCSnippetsTests",
            dependencies: ["XCSnippets"],
            resources: [
                .copy("Resources/D150D2CA-63D1-435C-B997-13A67073AA71.codesnippet"),
            ]
        ),
    ]
)
