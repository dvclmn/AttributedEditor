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
        "AttributedEditor",
        "EditorCore",
        "MarkdownHighlighter",
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
    .package(url: "https://github.com/ChimeHQ/Lowlight", branch: "main"),
    .package(url: "https://github.com/ChimeHQ/Neon", from: "0.6.0"),
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),

  ],
  targets: [
    .target(
      name: "AttributedEditor",
      dependencies: [
        .module(.editorCore),
        .module(.markdown),
        .themePark,
        //        .module(.textView),
        .coreTools,
      ]
    ),

    .target(
      name: "EditorCore",
      dependencies: [
        .module(.common),
        .module(.markdown),
        .colourKit,
        .coreTools,
        .neon,
        .themePark,
      ]
    ),

    .target(
      name: "MarkdownHighlighter",
      dependencies: [
        .module(.common),
        .colourKit,
        .coreTools,
        .neon,
        .themePark,
      ]
    ),

    // MARK: - Tests
    .testTarget(
      name: "EditorTests",
      dependencies: [
        .module(.editorCore),
        .module(.markdown),
        .module(.common),
      ],
      packageAccess: true,
    ),
  ]
)

extension Target.Dependency {

  static func module(_ baseModule: PackageModule) -> Self {
    .target(name: baseModule.name)
  }
  static var colourKit: Self {
    .product(name: "ColourKit", package: "BaseHelpers")
  }
  static var coreTools: Self {
    .product(name: "CoreTools", package: "BaseHelpers")
  }
  static var themePark: Self {
    .product(name: "ThemePark", package: "ThemePark")
  }
  static var neon: Self {
    .product(name: "Neon", package: "Neon")
  }
}

enum PackageModule {
  case attributedEditor
  case editorCore
//  case common
  case markdown

  var name: String {
    switch self {
      case .attributedEditor: return "AttributedEditor"
      case .editorCore: return "EditorCore"
//      case .common: return "HighlighterCommon"
      case .markdown: return "MarkdownHighlighter"
    }
  }
}
enum ExternalDependency {
  case colourKit
  case coreTools
  case themePark
  case neon
  case lowlight

  /// If different to product name
  var product: String? {
    switch self {
      case .colourKit: "ColourKit"
      case .coreTools: "CoreTools"
      case .themePark, .neon, .lowlight: nil
    }
  }
  var package: String {
    switch self {
      case .colourKit, .coreTools: "BaseHelpers"
      case .themePark: "ThemePark"
      case .neon: "Neon"
      case .lowlight: "Lowlight"
    }
  }
  var dependency: Target.Dependency {
    .product(name: product ?? package, package: package)
  }
}
