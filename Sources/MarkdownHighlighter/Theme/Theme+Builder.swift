//
//  Theme+Builder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit

extension Markdown.Theme {
  struct SyntaxStyleBuilder {
    // MARK: - Core Storage
    var content: TokenStyle?
    var background: CodableColour?
    var syntax: TokenStyle?
    var metadata: TokenStyle?

    // MARK: - Semantic Aliases

    /// The "Whack-a-mole" aliases
    /// These all just read/write to `metadata`, but make the call site readable.

    /// Alias for `metadata` when configuring Links or Images
    var url: TokenStyle? {
      get { metadata }
      set { metadata = newValue }
    }

    /// Alias for `metadata` when configuring Code Blocks
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

    if let c = builder.content { parts[.content] = c }
    if let t = builder.syntax { parts[.syntax] = t }
    if let m = builder.metadata { parts[.meta] = m }

    if let bg = builder.background {
      parts[.bg] = TokenStyle(colour: bg)
    }

    self.styles[syntax] = parts
  }
}
