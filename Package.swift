// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XCodeSnippets",
    products: [
        .library(
            name: "XCodeSnippets",
            targets: ["XCodeSnippets"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "XCodeSnippets",
            dependencies: []
        ),
        .testTarget(
            name: "XCodeSnippetsTests",
            dependencies: ["XCodeSnippets"],
            resources: [
                .copy("Resources/D150D2CA-63D1-435C-B997-13A67073AA71.codesnippet"),
            ]
        ),
    ]
)
