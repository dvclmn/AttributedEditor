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
        "HighlighterCommon",
        "Markdown",  // Highlighter and Theme(?)
        "TextView",
        "ThemeCommon",
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
        .module(.highlighter),
        .module(.editorCore),
        .module(.markdown),
        .module(.theme),
        .coreTools,
      ]
    ),
    
    .target(
      name: "EditorCore",
      dependencies: [
        .colourKit,
        .coreTools,
      ]
    ),
    .target(
      name: "HighlighterCommon",
      dependencies: [
        .module(.editorCore),
        .coreTools,
        .themePark,
      ]
    ),
    .target(
      name: "Markdown",
      dependencies: [
        .module(.highlighter),
        .module(.editorCore),
        .module(.theme),
        .colourKit,
        .coreTools,
        //        .product(name: "NSUI", package: "nsui"),
      ]
    ),
    .target(
      name: "TextView",
      dependencies: [
        .module(.highlighter),
        .module(.theme),
        .colourKit,
        .coreTools,
      ]
    ),
    .target(
      name: "ThemeCommon",
      dependencies: [
        .module(.editorCore),
        .colourKit,
        .coreTools,
        .themePark,
      ]
    ),
    
    // MARK: - Tests
    .testTarget(
      name: "EditorTests",
      dependencies: [
        .module(.editorCore),
        .module(.highlighter),
        .module(.markdown)
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
}

enum PackageModule {
  case attributedEditor
  case editorCore
  case highlighter
  case markdown
  case theme

  var name: String {
    switch self {
      case .attributedEditor: return "AttributedEditor"
      case .editorCore: return "EditorCore"
      case .highlighter: return "HighlighterCommon"
      case .markdown: return "Markdown"
      case .theme: return "ThemeCommon"
    }
  }
}
//enum ExternalDependency {
//  case baseHelpers
//  case themePark
//
//  var productName: String {
//    switch self {
//      case .baseHelpers: return "AttributedEditor"
//      case .themePark: return "EditorCore"
//    }
//  }
//  var packageName: String {
//     switch self {
//      case .baseHelpers: return "BaseHelpers"
//      case .themePark: return "ThemePark"
//    }
//  }
//}
