//
//  Theme+Colours.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension KeyPath: @retroactive @unchecked Sendable where Value == StyleRole {}

typealias StyleTokens = [Markdown.Syntax: [RolePath: StyleToken]]
public struct MarkdownTheme: Sendable {
  var styleDefinitions: StyleTokens = [:]
}

extension MarkdownTheme {

  subscript(syntax: Markdown.Syntax, role: RolePath) -> StyleToken? {
    get { styleDefinitions[syntax]?[role] }
    set { styleDefinitions[syntax]?[role] = newValue }
  }

  func updateTokens(
    for syntax: Markdown.Syntax,
    with styles: RoleStyles,
    _ tokens: inout StyleTokens,
  ) {
    tokens[syntax]?[.content] = styles.content
    tokens[syntax]?[.syntax] = styles.syntax
    tokens[syntax]?[.metadata] = styles.metadata
  }

  /// Looks up tokens given a syntax type and style role.
  /// If this specific token definition is not found, a default
  /// token for the role is returned.
  func styleToken(
    for syntax: Markdown.Syntax,
    role: RolePath
//    role: StyleRole
  ) -> StyleToken {

    /// Check specific definition using combined key
    if let token = self[syntax, role] {
      return token
    }
    return defaultToken(for: role)
  }

  /// Retrieves font/colour data from theme tokens
  func textAttributes(
    for token: StyleToken
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

  func textAttributes(
    syntax: Markdown.Syntax,
    role: RolePath,
//    role: StyleRole,
  ) -> TextAttributes {
    let token = styleToken(for: syntax, role: role)
    return textAttributes(for: token)
  }

  func defaultToken(for role: RolePath) -> StyleToken {
    //  func defaultToken(for role: StyleRole) -> StyleToken {
    switch role {
      case \.content: StyleToken(foreground: .primary)
      case \.syntax: StyleToken(foreground: .tertiary)
      case \.metadata: StyleToken(foreground: .secondary)
      //      case .content: StyleToken(foreground: .primary)
      //      case .syntax: StyleToken(foreground: .tertiary)
      //      case .metadata: StyleToken(foreground: .secondary)
      //      case .background: .default
      default: StyleToken.default
    }
  }

  /// The registration method maps the builder back to the generic parts
  /// See usage: ``Markdown/Theme/standard``
  mutating func register(
    _ syntax: Markdown.Syntax,
    //    role: StyleRole,
    //    _ syntaxID: Markdown.Syntax.ID,
    build: (inout RoleStyles) -> Void
  ) {
    var styles = RoleStyles()
    build(&styles)

    var tokens: StyleTokens = [:]

    tokens[SyntaxKey(syntax, .content)] = styles.content
    tokens[.syntax] = styles.syntax
    tokens[.metadata] = styles.metadata
    //    tokens[.background] = styles.background

    self.styleDefinitions[syntax] = tokens
  }

  //  private func update(role: StyleRole, for tokens: inout StyleTokens) {
  //
  //    tokens[SyntaxKey(syntax, role)] = tokens[keyPath: role.rolePath]
  //  }

}
