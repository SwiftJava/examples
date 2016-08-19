import PackageDescription

let package = Package(
    name: "examples",
    dependencies: [
        .Package(url: "https://github.com/SwiftJava/javax_swing.git", versions: Version(1,0,0)..<Version(2,0,0)),
        ]
)
