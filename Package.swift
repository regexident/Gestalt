// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Gestalt",
    products: [
        .library(
            name: "Gestalt",
            targets: [
                "Gestalt"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Gestalt",
            path: "Gestalt"
        ),
        .testTarget(
            name: "GestaltTests",
            dependencies: [
                "Gestalt"
            ],
            path: "GestaltTests"
        )
    ]
)
