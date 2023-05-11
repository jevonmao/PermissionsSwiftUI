// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let permissionsTargets: [Target] = [
    .target(
        name: "CorePermissionsSwiftUI",  //Internal module for shared code
        dependencies: ["Introspect"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"],
        resources: [.process("Resources")]
    ),
    .target(
        name: "PermissionsSwiftUI",  //Maintain backward compatibility - access to all permissions
        dependencies: ["Introspect", "CorePermissionsSwiftUI", "PermissionsSwiftUITracking", "PermissionsSwiftUIBluetooth", "PermissionsSwiftUICalendar", "PermissionsSwiftUICamera", "PermissionsSwiftUIContacts", "PermissionsSwiftUILocation", "PermissionsSwiftUILocationAlways", "PermissionsSwiftUIMicrophone", "PermissionsSwiftUIMotion", "PermissionsSwiftUIMusic", "PermissionsSwiftUINotification", "PermissionsSwiftUIPhoto", "PermissionsSwiftUIReminder", "PermissionsSwiftUISpeech", "PermissionsSwiftUIHealth"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUIBluetooth",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUICalendar",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUICamera",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUIContacts",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUIHealth",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"],
        swiftSettings: [
                        .define("PERMISSIONSWIFTUI_HEALTH")
                    ]
    ),
    .target(
        name: "PermissionsSwiftUILocationAlways",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"],
        swiftSettings: [
            .define("PERMISSIONSWIFTUI_LOCATION")
        ]
    ),
    .target(
        name: "PermissionsSwiftUILocation",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"],
        swiftSettings: [
            .define("PERMISSIONSWIFTUI_LOCATION")
        ]
    ),
    .target(
        name: "PermissionsSwiftUIMicrophone",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUIMotion",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUIMusic",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUINotification",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"],
        swiftSettings: [
            .define("PERMISSIONSWIFTUI_NOTIFICATION")
        ]
    ),
    .target(
        name: "PermissionsSwiftUIPhoto",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"],
        swiftSettings: [
            .define("PERMISSIONSWIFTUI_PHOTO")
        ]
    ),
    .target(
        name: "PermissionsSwiftUIReminder",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUISpeech",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUITracking",
        dependencies: ["Introspect", .target(name: "CorePermissionsSwiftUI")],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(name: "PermissionsSwiftUISiri",
            dependencies: ["Introspect", "CorePermissionsSwiftUI"],
            exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"])]

let package = Package(
    name: "PermissionsSwiftUI",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: permissionsTargets.map{Product.library(name: $0.name, targets: [$0.name])},
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", "1.0.0"..<"2.0.0"),
        .package(name: "Introspect", url: "https://github.com/siteline/SwiftUI-Introspect", "0.0.0"..<"1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .testTarget(name: "PermissionsSwiftUITests",
                    dependencies: ["SnapshotTesting", "PermissionsSwiftUI", "CorePermissionsSwiftUI"],
                    exclude: [],
                    resources: [.process("__Snapshots__")]),
        .testTarget(
            name: "PermissionsSwiftUISmallScreenTests",
            dependencies: ["SnapshotTesting"] + permissionsTargets
                                                    .map{Target.Dependency(stringLiteral: $0.name)},
            exclude: [],
            resources: [.process("__Snapshots__")]
        ),
        
    ] + permissionsTargets
)
