// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let permissionsTargets: [Target] = [
    .target(
        name: "CorePermissionsSwiftUI",  //Internal module for shared code
        dependencies: ["Introspect"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUI",  //Maintain backward compatibility - access to all permissions
        dependencies: ["Introspect", "CorePermissionsSwiftUI", "PermissionsSwiftUITracking"],
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
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUILocationAlways",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUILocation",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
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
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
    ),
    .target(
        name: "PermissionsSwiftUIPhoto",
        dependencies: ["Introspect", "CorePermissionsSwiftUI"],
        exclude: ["../../Tests/PermissionsSwiftUITests/__Snapshots__"]
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
    ),]


let package = Package(
    name: "PermissionsSwiftUI",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PermissionsSwiftUIBluetooth",
            targets: ["PermissionsSwiftUIBluetooth"]
        ),
        .library(
            name: "PermissionsSwiftUICalendar",
            targets: ["PermissionsSwiftUICalendar"]
        ),
        .library(
            name: "PermissionsSwiftUICamera",
            targets: ["PermissionsSwiftUICamera"]
        ),
        .library(
                name: "PermissionsSwiftUIContacts",
                targets: ["PermissionsSwiftUIContacts"]
        ),
        .library(name: "PermissionsSwiftUIHealth",
                targets: ["PermissionsSwiftUIHealth"]
        ),
        .library(name: "PermissionsSwiftUILocationAlways",
                targets: ["PermissionsSwiftUILocationAlways"]
        ),
        .library(name: "PermissionsSwiftUILocation",
                targets: ["PermissionsSwiftUILocation"]
        ),
        .library(name: "PermissionsSwiftUIMicrophone",
                targets: ["PermissionsSwiftUIMicrophone"]
        ),
        .library(name: "PermissionsSwiftUIMotion",
                targets: ["PermissionsSwiftUIMotion"]
        ),
        .library(name: "PermissionsSwiftUIMusic",
                targets: ["PermissionsSwiftUIMusic"]
        ),
        .library(name: "PermissionsSwiftUINotification",
                targets: ["PermissionsSwiftUINotification"]
        ),
        .library(name: "PermissionsSwiftUIPhoto",
                targets: ["PermissionsSwiftUIPhoto"]
        ),
        .library(name: "PermissionsSwiftUIReminder",
                targets: ["PermissionsSwiftUIReminder"]
        ),
        .library(name: "PermissionsSwiftUISpeech",
                targets: ["PermissionsSwiftUISpeech"]
        ),
        .library(name: "PermissionsSwiftUITracking",
                targets: ["PermissionsSwiftUITracking"]
        ),
        .library(name: "PermissionSwiftUI",
                 targets: ["PermissionsSwiftUI"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", "1.0.0"..<"2.0.0"),
        .package(name: "Introspect", url: "https://github.com/siteline/SwiftUI-Introspect", "0.0.0"..<"1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .testTarget(name: "PermissionsSwiftUITests",
                    dependencies: ["SnapshotTesting"] + permissionsTargets
                                                            .map{Target.Dependency(stringLiteral: $0.name)},
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
