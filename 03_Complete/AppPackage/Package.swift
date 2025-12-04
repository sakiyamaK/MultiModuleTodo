// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppPackage",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "AppRoot", targets: ["AppRoot"]),
        .library(name: "TodoList", targets: ["TodoList"]),
        .library(name: "TodoDetail", targets: ["TodoDetail"]),
    ],
    targets: [
        .target(
            name: "Model"
        ),
        .target(
            name: "AppRouterInterface",
            dependencies: ["Model"],
            path: "Sources/AppRouter/Interface"
        ),
        .target(
            name: "Network",
            dependencies: ["Model"],
            resources: [.process("Resources")]
        ),
        .target(
            name: "TodoList",
            dependencies: ["Model", "Network", "AppRouterInterface"]
        ),
        .target(
            name: "TodoDetail",
            dependencies: ["Model", "Network", "AppRouterInterface"]
        ),
        .target(
            name: "AppRouterImpl",
            dependencies: ["TodoList", "TodoDetail", "AppRouterInterface"],
            path: "Sources/AppRouter/Impl"
        ),
        .target(
            name: "AppRoot",
            dependencies: ["AppRouterImpl"]
        ),
    ]
)
