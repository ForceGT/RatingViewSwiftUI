// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "RatingView",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "RatingView",
            targets: ["RatingView"]),
    ],
    targets: [
        .target(
            name: "RatingView",
            dependencies: []),
        
    ],
    swiftLanguageVersions: [.v5]
)
