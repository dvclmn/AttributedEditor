//
//  Theme+Builder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit
import CoreTools
import ThemePark

/// Surely just use this?
/// https://github.com/swiftlang/swift-markdown
/// Also:
/// https://developer.apple.com/documentation/foundation/attributedstring/markdownsourceposition
extension Markdown.Theme {
  struct SyntaxStyleBuilder {
    /// These correspond directly to ``Markdown/SyntaxPart``
    var content: TokenStyle?
    var syntax: TokenStyle?
    var metadata: TokenStyle?
    var background: TokenStyle?
  }
}

extension Markdown.Theme.SyntaxStyleBuilder {

  /// Re the below `url`, `languageHint` and `icon`:
  /// Originally these were the problematic "Whack-a-mole" aliases
  /// These all just read/write to `metadata`, but make the call site readable.

  /// An alias for `metadata` when configuring Links or Images
  var url: TokenStyle? {
    get { metadata }
    set { metadata = newValue }
  }

  /// An Alias for `metadata` when configuring Code Blocks
  /// Consider: https://developer.apple.com/documentation/foundation/attributescopes/foundationattributes/languageidentifier
  var languageHint: TokenStyle? {
    get { metadata }
    set { metadata = newValue }
  }

  /// Alias for `metadata` when configuring Callouts
  var icon: TokenStyle? {
    get { metadata }
    set { metadata = newValue }
  }
}

extension Markdown.Theme {
  /// The registration method maps the builder back to the generic parts
  /// See usage: ``Markdown/Theme/standard``
  mutating func register(
    _ syntax: Markdown.Syntax,
    build: (inout SyntaxStyleBuilder) -> Void
  ) {
    var builder = SyntaxStyleBuilder()
    build(&builder)

    var parts: PartTokens = [:]

    parts[.content] = builder.content
    parts[.syntax] = builder.syntax
    parts[.metadata] = builder.metadata
    parts[.background] = builder.background

    self.styleDefinitions[syntax] = parts
  }

}
