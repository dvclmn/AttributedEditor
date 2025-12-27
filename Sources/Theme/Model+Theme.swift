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

typealias StyleTokens = [StyleRole: StyleToken]

extension Markdown {
  public struct Theme: Highlighter.Theme, @unchecked Sendable {
    var styleDefinitions: [Markdown.Syntax.ID: StyleTokens] = [:]
  }
}

extension Markdown.Theme {
  
  func backgroundStyle(
    for syntax: Markdown.Syntax,
//    for syntaxID: Markdown.Syntax.ID,
    role: StyleRole
  ) -> BackgroundStyle? {
    switch syntax {
      case .inlineCode:
        return .roundedRect(.pink, cornerRadius: 3)
        
      case .codeBlock where role == .content:
        return .roundedRect(.indigo, cornerRadius: 3)
        
      default:
        return nil
    }
  }

  static var basicCodeBackground: CodeBackground { .init() }

  /// Extracts font/colour data from theme tokens,
  /// and populates attributes for this syntax part
  ///
  /// Note: `NSTextAttributes` can only carry *one*
  /// entry at a time, for a key. E.g. foreground, font, etc.
  ///
  /// So this can only handle one 'piece', like a syntax
  /// part/fragment, at once.
  func textAttributes(
    for syntaxID: Markdown.Syntax.ID,
    role styleRole: StyleRole,
  ) -> TextAttributes {

    let token = style(for: syntaxID, styleRole: styleRole)
    var attrs = TextAttributes()

    attrs[.foregroundColor] = token.nsColour
    attrs[.fontTraits] = token.fontTraits

    if token.hasBackground {
      attrs[.codeBackground] = Self.basicCodeBackground
    }

    //    if styleRole == .background {
    //    } else {
    //    }
    return attrs
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
  private func style(
    for syntaxID: Markdown.Syntax.ID,
    styleRole: Markdown.StyleRole
  ) -> StyleToken {

    /// Check specific definition
    if let specific = styleDefinitions[syntaxID]?[styleRole] {
      return specific
    }
    return defaultToken(for: styleRole)
  }

  func defaultToken(for part: Markdown.StyleRole) -> StyleToken {
    switch part {
      case .content: StyleToken(colour: .primary)
      case .syntax: StyleToken(colour: .tertiary)
      case .metadata: StyleToken(colour: .secondary)
      case .background: .default
    }
  }
}

