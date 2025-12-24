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

  struct StyleBuilder {
    /// These correspond directly to ``Markdown/StyleRole``
    var content: StyleToken?
    var syntax: StyleToken?
    var metadata: StyleToken?
    var background: StyleToken?
  }
}

extension Markdown.Theme.StyleBuilder {

  /// Re the below `url`, `languageHint` and `icon`:
  /// Originally these were the problematic "Whack-a-mole" aliases
  /// These all just read/write to `metadata`, but make the call site readable.

  /// An alias for `metadata` when configuring Links or Images
  var url: StyleToken? {
    get { metadata }
    set { metadata = newValue }
  }

  /// An Alias for `metadata` when configuring Code Blocks
  /// Consider: https://developer.apple.com/documentation/foundation/attributescopes/foundationattributes/languageidentifier
  var languageHint: StyleToken? {
    get { metadata }
    set { metadata = newValue }
  }

  /// Alias for `metadata` when configuring Callouts
  var icon: StyleToken? {
    get { metadata }
    set { metadata = newValue }
  }
}

extension Markdown.Theme {
  /// The registration method maps the builder back to the generic parts
  /// See usage: ``Markdown/Theme/standard``
  mutating func register(
    _ syntax: Markdown.Syntax,
    //    _ syntaxID: Markdown.Syntax.ID,
    build: (inout StyleBuilder) -> Void
  ) {
    var builder = StyleBuilder()
    build(&builder)

    var tokens: StyleTokens = [:]

    tokens[.content] = builder.content
    tokens[.syntax] = builder.syntax
    tokens[.metadata] = builder.metadata
    tokens[.background] = builder.background

    self.styleDefinitions[syntax.id] = tokens
  }
}
