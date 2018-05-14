// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Gestalt",

    dependencies: [
    ],

    targets: [
        .target    (name         : "Gestalt", 
                    path         : "Gestalt"),
        .testTarget(name         : "GestaltTests", 
                    dependencies : [ "Gestalt" ],
                    path         : "GestaltTests")
    ]
)
