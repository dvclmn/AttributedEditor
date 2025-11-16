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
    
//    .package(url: "https://github.com/raspu/Highlightr.git", from: "2.2.1"),
    //    .package(url: "https://github.com/ChimeHQ/Glyph.git", branch: "main"),
    //    .package(url: "https://github.com/ChimeHQ/ThemePark.git", branch: "main"),
//    .package(url: "https://github.com/dvclmn/BaseStyles.git", branch: "main"),
    .package(url: "https://github.com/dvclmn/BaseHelpers", branch: "main"),
//    .package(url: "https://github.com/ChimeHQ/Rearrange.git", from: "2.0.0"),
//    .package(url: "https://github.com/ChimeHQ/Neon", branch: "main"),
//    .package(url: "https://github.com/alex-pinkus/tree-sitter-swift", branch: "with-generated-files"),
//    .package(url: "https://github.com/tree-sitter-grammars/tree-sitter-markdown.git", branch: "split_parser"),
//    .package(url: "https://github.com/gohanlon/swift-memberwise-init-macro.git", from: "0.5.0"),
  ],
  targets: [
    .target(
      name: "MarkdownEditor",
      dependencies: [
//        "Neon",
//        "Rearrange",
//        .product(name: "MemberwiseInit", package: "swift-memberwise-init-macro"),
//        .product(name: "TreeSitterSwift", package: "tree-sitter-swift"),
//        .product(name: "TreeSitterMarkdown", package: "tree-sitter-markdown"),
        .product(name: "SharedHelpers", package: "BaseHelpers"),
//        .product(name: "BaseStyles", package: "BaseStyles"),
      ]
    ),
  ]
)
