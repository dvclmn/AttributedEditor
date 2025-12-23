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

typealias StyleTokens = [Markdown.StyleRole: StyleToken]

extension Markdown {
  public struct Theme: Highlighter.Theme, @unchecked Sendable {
    var styleDefinitions: [Markdown.Syntax: StyleTokens] = [:]
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
    part: Markdown.StyleRole,
  ) -> TextAttributes {

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
  /// being bit more opinionated, if fallback returned.
  /// (E.g. this decides that syntax is grey, etc)
  func style(
    for syntax: Markdown.Syntax,
    part: Markdown.StyleRole

  ) -> StyleToken {

    /// Check specific definition
    if let specific = styleDefinitions[syntax]?[part] {
      return specific
    }
    return defaultToken(for: part)
  }

  func defaultToken(for part: Markdown.StyleRole) -> StyleToken {
    switch part {
      case .content: StyleToken(colour: .primary)
      case .syntax: StyleToken(colour: .tertiary)
      case .metadata: StyleToken(colour: .secondary)
      case .background: .blank
    }
  }

}
