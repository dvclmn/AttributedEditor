// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "AttributedEditor",
  platforms: [
    .macOS("14.0")
  ],
  products: [
    .library(
      name: "AttributedEditor",
      targets: ["AttributedEditor"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/dvclmn/BaseHelpers", branch: "main"),
    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0"),

  ],
  targets: [
    .target(
      name: "AttributedEditor",
      dependencies: [
        .product(name: "ColourKit", package: "BaseHelpers"),
        .product(name: "CoreTools", package: "BaseHelpers"),
        .product(name: "NSUI", package: "nsui")
      ]
    ),
  ]
)
