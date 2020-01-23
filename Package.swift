// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SkyFloatingLabelTextField",
    platforms: [.iOS("8.0")],
    products: [
      .library(name: "SkyFloatingLabelTextField", targets: ["SkyFloatingLabelTextField"])
    ],
    targets: [
        .target(
            name: "SkyFloatingLabelTextField",
            path: "Sources"
        ),
        .testTarget(
            name: "SkyFloatingLabelTextFieldTests",
            dependencies: ["SkyFloatingLabelTextField"],
            path: "SkyFloatingLabelTextField/SkyFloatingLabelTextFieldTests"
        )
    ],
    swiftLanguageVersions: [.v4_2]
)
