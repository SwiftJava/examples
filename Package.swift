import PackageDescription

let package = Package(
    name: "examples",
    dependencies: [
        .Package(url: "https://github.com/SwiftJava/javax_swing.git", versions: Version(2,1,0)..<Version(3,0,0)),
        ]
)
