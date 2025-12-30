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
    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0"),
    //    .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.4"),
    //    .package(url: "https://github.com/ChimeHQ/Rearrange", from: "2.0.0"),
    .package(url: "https://github.com/ChimeHQ/Glyph", branch: "main"),
    //    .package(url: "https://github.com/ChimeHQ/Lowlight", branch: "main"),
    //    .package(url: "https://github.com/ChimeHQ/ThemePark", branch: "main"),
//    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),

  ],
  targets: [
    .target(
      name: "AttributedEditor",
      dependencies: [
        .local(.editorCore),
        .local(.markdown),
        .external(.coreTools),
      ]
    ),

    .target(
      name: "EditorCore",
      dependencies: [
        .local(.markdown),
        .external(.colourKit),
        .external(.coreTools),
        .external(.nsui),
        .external(.glyph),
      ]
    ),

    .target(
      name: "MarkdownHighlighter",
      dependencies: [
        .external(.colourKit),
        .external(.coreTools),

      ]
    ),

    // MARK: - Tests
    .testTarget(
      name: "EditorTests",
      dependencies: [
        .local(.editorCore),
        .local(.markdown),
      ],
    ),
  ]
)

extension Target.Dependency {

  static func local(_ baseModule: PackageModule) -> Self {
    .target(name: baseModule.name)
  }
  static func external(_ package: ExternalDependency) -> Self {
    package.dependency
  }
}

enum PackageModule {
  case attributedEditor
  case editorCore

  case markdown

  var name: String {
    switch self {
      case .attributedEditor: return "AttributedEditor"
      case .editorCore: return "EditorCore"
      case .markdown: return "MarkdownHighlighter"
    }
  }
}
enum ExternalDependency {
  case colourKit
  case coreTools
  case nsui
  case glyph

  /// If different to product name
  var product: String? {
    switch self {
      case .colourKit: "ColourKit"
      case .coreTools: "CoreTools"
      case .nsui: nil
      case .glyph: nil
    }
  }
  var package: String {
    switch self {
      case .colourKit, .coreTools: "BaseHelpers"
      case .nsui: "NSUI"
      case .glyph: "Glyph"

    }
  }
  var dependency: Target.Dependency {
    .product(name: product ?? package, package: package)
  }
}
