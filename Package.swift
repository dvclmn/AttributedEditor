// swift-tools-version: 6.2

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "AttributedEditor",
  platforms: [
    .macOS("14.0")
  ],
  products: [
    .library(
      name: "AttributedEditor",
      targets: [
        "EditorCore",
        "AttributedEditor",
        "HighlighterCommon",
        "MarkdownHighlighter",
        "Theme",
      ]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/dvclmn/BaseHelpers", branch: "main"),
    //    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0"),
//    .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.4"),
//    .package(url: "https://github.com/ChimeHQ/Rearrange", from: "2.0.0"),
//    .package(url: "https://github.com/ChimeHQ/Glyph", branch: "main"),
    .package(url: "https://github.com/ChimeHQ/ThemePark", branch: "main"),
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),

  ],
  targets: [
    .target(
      name: "AttributedEditor",
      dependencies: [
        "HighlighterCommon",
        "EditorCore",
        "MarkdownHighlighter",
        .product(name: "CoreTools", package: "BaseHelpers"),
        //        .product(name: "Sharing", package: "swift-sharing"),
      ]
    ),
    .target(
      name: "EditorCore",
      dependencies: [
        "HighlighterCommon",
        .product(name: "ColourKit", package: "BaseHelpers"),
        .product(name: "CoreTools", package: "BaseHelpers"),
        //        .product(name: "NSUI", package: "nsui"),
//        .product(name: "Sharing", package: "swift-sharing"),
      ]
    ),
    .target(
      name: "HighlighterCommon",
      dependencies: [
        .product(name: "CoreTools", package: "BaseHelpers"),
        .product(name: "ThemePark", package: "ThemePark"),
        //        .product(name: "Sharing", package: "swift-sharing"),
      ]
    ),
    .target(
      name: "MarkdownHighlighter",
      dependencies: [
        "HighlighterCommon",
        .product(name: "ColourKit", package: "BaseHelpers"),
        .product(name: "CoreTools", package: "BaseHelpers"),
        //        .product(name: "NSUI", package: "nsui"),
      ]
    ),
    .target(
      name: "Theme",
      dependencies: [
        "HighlighterCommon",
        .product(name: "ColourKit", package: "BaseHelpers"),
        .product(name: "CoreTools", package: "BaseHelpers"),
        .product(name: "ThemePark", package: "ThemePark"),
        //        .product(name: "NSUI", package: "nsui"),
      ]
    ),
    .testTarget(
      name: "EditorTests",
      dependencies: ["EditorCore", "HighlighterCommon", "MarkdownHighlighter"],
      packageAccess: true,
    )
//    .target(
//      name: "BasicHighlighter",
//      dependencies: [
//        "HighlighterCommon",
//        .product(name: "ColourKit", package: "BaseHelpers"),
//        .product(name: "CoreTools", package: "BaseHelpers"),
//        //        .product(name: "NSUI", package: "nsui"),
//      ]
//    ),
  ]
)
