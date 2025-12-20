//
//  Theme+Builder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit

/// Surely just use this?
/// https://github.com/swiftlang/swift-markdown
/// Also:
/// https://developer.apple.com/documentation/foundation/attributedstring/markdownsourceposition
extension Markdown.Theme {
  struct SyntaxStyleBuilder {

    // MARK: - Core Storage
    var content: TokenStyle?
    var background: CodableColour?
    var syntax: TokenStyle?
    var metadata: TokenStyle?

    // MARK: - Semantic Aliases

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

  /// The registration method maps the builder back to the generic parts
  mutating func register(
    _ syntax: Markdown.Syntax, build: (inout SyntaxStyleBuilder) -> Void
  ) {
    var builder = SyntaxStyleBuilder()
    build(&builder)

    var parts: [Markdown.SyntaxPart: TokenStyle] = [:]

    if let content = builder.content { parts[.content] = content }
    if let syntax = builder.syntax { parts[.syntax] = syntax }
    if let meta = builder.metadata { parts[.meta] = meta }
    
    /// Remember: `background` has a colour only, no full `TokenStyle`,
    /// so it is created inline here from the colour.
    if let bg = builder.background { parts[.bg] = TokenStyle(colour: bg) }

    self.styleDefinitions[syntax] = parts
  }
}
