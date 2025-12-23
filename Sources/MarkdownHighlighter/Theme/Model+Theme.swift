//
//  Theme+Colours.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit
import CoreTools
import HighlighterCommon
import ThemePark

typealias PartTokens = [Markdown.SyntaxPart: TokenStyle]

extension Markdown {
  public struct Theme: Highlighter.Theme, @unchecked Sendable {
    var styleDefinitions: [Markdown.Syntax: PartTokens] = [:]
  }
}

extension Markdown.Theme {

  /// Extracts font/colour data from theme tokens,
  /// and populates attributes for this syntax part
  ///
  /// Note: `TextAttributes` can only carry *one*
  /// entry at a time, for a key. E.g. foreground, font, etc.
  ///
  /// So this can only handle one 'piece', like a syntax
  /// part/fragment, at once.
  func textAttributes(
    for syntax: Markdown.Syntax,
    //    parts: [Markdown.SyntaxPart],
    part: Markdown.SyntaxPart,
    //    to attributes: inout [NSAttributedString.Key: Any]
    //    to attributes: inout TextAttributes
  ) -> TextAttributes {
    /// Start with 2x parts, just syntax and content?
    /// Or whatever is provided here I guess
    //    for part in parts {
    let token = style(for: syntax, part: part)
    var attributes: TextAttributes = [:]
    attributes[.foregroundColor] = token.nsColour
    attributes[.fontTraits] = token.fontTraits

    return attributes

  }

  /// This simply provides a neater API, to read into the
  /// contents of the `styleDefinitions` property
  ///
  /// ~~There may not always be a specific token for a given
  /// syntax/part, so this may return nil.~~
  /// Still figuring out whether to have fallback approach,
  /// or return nil. Main difference is this method ends up
  /// being bit more opnionayed, if fallback returned.
  /// (E.g. this decides that syntax is greyer, etc)
  func style(
    for syntax: Markdown.Syntax,
    part: Markdown.SyntaxPart

  ) -> TokenStyle {

    /// 1. Check specific definition (e.g., Bold > Content)
    if let specific = styleDefinitions[syntax]?[part] {
      return specific
    }

    /// If the above returns nothing
    return defaultToken(for: part)
  }

  func defaultToken(for part: Markdown.SyntaxPart) -> TokenStyle {
    switch part {
      case .content: TokenStyle(colour: .primary)
      case .syntax: TokenStyle(colour: .tertiary)
      case .metadata: TokenStyle(colour: .secondary)
      case .background: .blank
    }
  }

}
