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
    //    .package(url: "https://github.com/ChimeHQ/Glyph", branch: "main"),
    .package(url: "https://github.com/tree-sitter-grammars/tree-sitter-markdown", branch: "split_parser"),
    .package(url: "https://github.com/ChimeHQ/ThemePark", branch: "main"),
    .package(url: "https://github.com/ChimeHQ/Lowlight", branch: "main"),
    .package(url: "https://github.com/ChimeHQ/Neon", from: "0.6.0"),
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),

  ],
  targets: [
    .target(
      name: "AttributedEditor",
      dependencies: [
        .local(.editorCore),
        .local(.markdown),
        .exteral(.themePark),
        .exteral(.coreTools),
      ]
    ),

    .target(
      name: "EditorCore",
      dependencies: [
        .local(.markdown),
        .exteral(.colourKit),
        .exteral(.coreTools),
        .exteral(.neon),
        .exteral(.themePark),
        .exteral(.lowlight),
        .exteral(.nsui),
        .exteral(.treeSitterMarkdown),
      ]
    ),

    .target(
      name: "MarkdownHighlighter",
      dependencies: [
        .exteral(.colourKit),
        .exteral(.coreTools),
        .exteral(.neon),
        .exteral(.themePark),
        .exteral(.lowlight),
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
  static func exteral(_ package: ExternalDependency) -> Self {
    package.dependency
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
  case nsui
  case treeSitterMarkdown
//  case treeSitterMarkdownInline

  /// If different to product name
  var product: String? {
    switch self {
      case .colourKit: "ColourKit"
      case .coreTools: "CoreTools"
      case .themePark, .neon, .lowlight, .nsui: nil
      case .treeSitterMarkdown: "TreeSitterMarkdown"
//      case .treeSitterMarkdownInline: "TreeSitterMarkdownInline"
    }
  }
  var package: String {
    switch self {
      case .colourKit, .coreTools: "BaseHelpers"
      case .themePark: "ThemePark"
      case .neon: "Neon"
      case .lowlight: "Lowlight"
      case .nsui: "NSUI"
      case .treeSitterMarkdown: "tree-sitter-markdown"
    }
  }
  var dependency: Target.Dependency {
    .product(name: product ?? package, package: package)
  }
}
