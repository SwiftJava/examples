// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "examples",
    products: [
        .executable(name: "examples", targets: ["examples"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftJava/javax_swing.git", .branch("master")),
        ],
    targets: [
        .target(name: "examples", dependencies: ["javax_swing"], path: "Sources/"),
    ]
)
