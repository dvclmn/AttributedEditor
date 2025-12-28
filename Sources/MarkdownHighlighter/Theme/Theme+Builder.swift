//
//  Theme+Builder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit
import CoreTools
//import ThemePark
//import EditorCore

/// Surely just use this?
/// https://github.com/swiftlang/swift-markdown
/// Also:
/// https://developer.apple.com/documentation/foundation/attributedstring/markdownsourceposition
//extension Highlighter.Theme {

  //  struct StyleBuilder {
  //    /// These correspond directly to ``Markdown/StyleRole``
  //    var content: StyleToken?
  //    var syntax: StyleToken?
  //    var metadata: StyleToken?
  //    var background: Bool = false
  ////    var background: StyleToken?
  //  }
//}

struct RoleStyles {
  var content: StyleToken?
  var syntax: StyleToken?
  var metadata: StyleToken?
}

extension RoleStyles {

  /// The `url`, `languageHint`, `icon` accessors are nice,
  /// but they belong either:
  /// - in Markdown-specific builder extensions
  /// - as convenience APIs layered on top of the core theme.
  ///
  /// Re the below `url`, `languageHint` and `icon`:
  /// Originally these were the problematic "Whack-a-mole" aliases
  /// These all just read/write to `metadata`, but make the call site readable.

  /// An alias for `metadata` when configuring Links or Images
  //  var url: StyleToken? {
  //    get { metadata }
  //    set { metadata = newValue }
  //  }
  //
  //  /// An Alias for `metadata` when configuring Code Blocks
  //  /// Consider: https://developer.apple.com/documentation/foundation/attributescopes/foundationattributes/languageidentifier
  //  var languageHint: StyleToken? {
  //    get { metadata }
  //    set { metadata = newValue }
  //  }
  //
  //  /// Alias for `metadata` when configuring Callouts
  //  var icon: StyleToken? {
  //    get { metadata }
  //    set { metadata = newValue }
  //  }
}

extension MarkdownTheme {
  /// The registration method maps the builder back to the generic parts
  /// See usage: ``Markdown/Theme/standard``
  mutating func register(
    _ syntax: Markdown.Syntax,
    //    _ syntaxID: Markdown.Syntax.ID,
    build: (inout RoleStyles) -> Void
  ) {
    var styles = RoleStyles()
    build(&styles)

    var tokens: StyleTokens = [:]

//    if let content = builder.content {
//      tokens[.content] = content
//    }
//    if let syntax = builder.syntax {
//      tokens[.syntax] = syntax
//    }
//    if let metadata = builder.metadata {
//      tokens[.metadata] = metadata
//    }
//    if let background = builder.background {
//      tokens[.background] = background
//    }

    tokens[.content] = styles.content
    tokens[.syntax] = styles.syntax
    tokens[.metadata] = styles.metadata
//    tokens[.background] = styles.background

    self.styleDefinitions[syntax] = tokens
  }
}
