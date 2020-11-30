// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Marshal",
	platforms: [
		.iOS(.v12)
	],
    products: [
        .library(
            name: "Marshal",
            targets: ["Marshal"]
		)
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Marshal",
            path: "Sources"
		),
        .testTarget(
            name: "MarshalTests",
            dependencies: ["Marshal"],
            path: "MarshalTests"
		)
	],
	swiftLanguageVersions: [.v5]
)
