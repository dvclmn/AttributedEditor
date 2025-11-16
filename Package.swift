// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "MarkdownEditor",
  platforms: [
    .macOS("14.0")
  ],
  products: [
    .library(
      name: "MarkdownEditor",
      targets: ["MarkdownEditor"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/dvclmn/BaseHelpers", branch: "main"),

  ],
  targets: [
    .target(
      name: "MarkdownEditor",
      dependencies: [
        .product(name: "SharedHelpers", package: "BaseHelpers"),
      ]
    ),
  ]
)
