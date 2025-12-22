//
//  Theme+Colours.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit
import HighlighterCommon
import CoreTools

typealias PartTokens = [Markdown.SyntaxPart: TokenStyle]

extension Markdown {
  public struct Theme: Highlighter.Theme, @unchecked Sendable {
    var styleDefinitions: [Markdown.Syntax: PartTokens] = [:]
  }
}

/// Consider trying TaskLocal (like for Wrecktangle)
/// to avoid needing to always provide syntax?
/// ```
/// enum Context {
///   @TaskLocal static var currentRole: Box.PartRole?
/// }
/// ```
extension Markdown.Theme {
  
  func applyTokens(
    for syntax: Markdown.Syntax,
    parts: [Markdown.SyntaxPart],
//    part: Markdown.SyntaxPart,
    //    to attributes: inout [NSAttributedString.Key: Any]
    to attributes: inout TextAttributes
  ) {
    /// Start with 2x parts, just syntax and content?
    let token = style(for: syntax, part: part)
    //    let contentToken = style(for: syntax, part: .content)
    
    attributes[.foregroundColor] = token.nsColour
    attributes[.fontTraits] = token.fontTraits
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
