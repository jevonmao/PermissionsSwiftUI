// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PermissionsSwiftUI",
    platforms: [.iOS(.v11), .tvOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PermissionsSwiftUI",
            targets: ["PermissionsSwiftUI"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", "1.0.0"..<"2.0.0"),
        .package(name: "Introspect", url: "https://github.com/siteline/SwiftUI-Introspect", "0.0.0"..<"1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PermissionsSwiftUI",
            dependencies: ["Introspect"],
            exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
        ),
        .testTarget(name: "PermissionsSwiftUITests",
                    dependencies: ["PermissionsSwiftUI","SnapshotTesting"],
                    exclude: [],
                    resources: [.process("__Snapshots__")]),
        .testTarget(
            name: "PermissionsSwiftUISmallScreenTests",
            dependencies: ["PermissionsSwiftUI","SnapshotTesting"],
            exclude: [],
            resources: [.process("__Snapshots__")]
        ),
    ]
)
