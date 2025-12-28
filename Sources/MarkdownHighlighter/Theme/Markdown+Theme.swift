//
//  Theme+Colours.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit
import CoreTools

struct SyntaxRoleKey: Hashable {
  let syntax: Markdown.Syntax
  let role: StyleRole
}

//public typealias StyleTokens = [StyleRole: StyleToken]

public struct MarkdownTheme: Sendable {
  var styleDefinitions: [SyntaxRoleKey: StyleToken] = [:]
}

extension MarkdownTheme {

  //  func backgroundStyle(
  //    for syntax: Markdown.Syntax,
  //    role: StyleRole
  //  ) -> StyleToken.BackgroundStyle? {
  //    switch syntax {
  //      case .inlineCode:
  //        return .roundedRect(.pink, cornerRadius: 3)
  //
  //      case .codeBlock where role == .content:
  //        return .roundedRect(.indigo, cornerRadius: 3)
  //
  //      default:
  //        return nil
  //    }
  //  }
  //
  //  static var basicCodeBackground: CodeBackground { .init() }

}

extension MarkdownTheme {
  //  public var font: NSFont { NSFont.systemFont(ofSize: 14) }
  public var textColour: NSColor { .textColor }

  //  public mutating func updateFont(with newFont: NSFont) {
  //    self.font = newFont
  //  }

  /// Extracts font/colour data from theme tokens,
  /// and populates attributes for this syntax part
  ///
  /// Note: `NSTextAttributes` can only carry *one*
  /// entry at a time, for a key. E.g. foreground, font, etc.
  ///
  /// So this can only handle one 'piece', like a syntax
  /// part/fragment, at once.
  func textAttributes(
    for token: StyleToken
      //    for syntaxID: Markdown.Syntax.ID,
      //    role styleRole: StyleRole,
  ) -> TextAttributes {

    //    let token = style(for: syntaxID, styleRole: styleRole)
    var attrs = TextAttributes()
    //
    attrs[.foregroundColor] = token.foreground?.nsColor
    attrs[.fontTraits] = token.fontTraits
    //
    //#warning("Theme approach is WIP")
    //    if token.hasBackground {
    //      attrs[.codeBackground] = Self.basicCodeBackground
    //    }

    //    if styleRole == .background {
    //    } else {
    //    }
    return attrs
  }

  /// This simply provides a neater API, to read into the
  /// contents of the `styleDefinitions` property.
  ///
  /// This method looks up tokens using the combined `SyntaxRoleKey`
  /// instead of nested dictionaries.
  /// If no specific token is found, a default token for the role is returned.
  public func styleToken(
    syntax: Markdown.Syntax,
    role: StyleRole
      //    for syntaxID: Markdown.Syntax.ID,
      //    styleRole: Markdown.StyleRole
  ) -> StyleToken {

    /// Check specific definition using combined key
    if let token = styleDefinitions[SyntaxRoleKey(syntax: syntax, role: role)] {
      return token
    }
    return defaultToken(for: role)
  }

  func defaultToken(for role: StyleRole) -> StyleToken {
    switch role {
      case .content: StyleToken(foreground: .primary)
      case .syntax: StyleToken(foreground: .tertiary)
      case .metadata: StyleToken(foreground: .secondary)
    //      case .background: .default
    }
  }

}
