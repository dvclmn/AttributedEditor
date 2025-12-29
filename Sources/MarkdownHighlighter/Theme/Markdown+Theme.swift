//
//  Theme+Colours.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit
import CoreTools

typealias StyleTokens = [Markdown.Syntax: StyleRoles]

public struct MarkdownTheme: Sendable {
  var styleDefinitions: StyleTokens = [:]
}

extension MarkdownTheme {

  init(@ThemeBuilder builder: () -> [SyntaxRoleDef]) {
    var tokens: StyleTokens = [:]
    for def in builder() {
      /// Also option for a merge operation rather than straight
      /// replace if preferred: ``StyleRoles/merge(_:prefer:)``
      tokens[def.syntax] = def.roles
    }
    self.styleDefinitions = tokens
  }

  subscript(syntax: Markdown.Syntax, role: StyleRole) -> StyleToken? {
    get { styleDefinitions[syntax]?[role] }
    set { styleDefinitions[syntax]?[role] = newValue }
  }

  /// Looks up tokens given a syntax type and style role.
  /// If this specific token definition is not found, a default
  /// token for the role is returned.
  func styleToken(
    for syntax: Markdown.Syntax,
    role: StyleRole
  ) -> StyleToken {

    /// Check for specific definition first
    if let token = self[syntax, role] {
      return token
    }
    return defaultToken(for: role)
  }

  /// Retrieves font/colour data from theme tokens
  func textAttributes(
    for token: StyleToken
  ) -> TextAttributes {
    var attrs = TextAttributes()
    attrs[.foregroundColor] = token.foreground?.nsColor
    attrs[.fontTraits] = token.fontTraits

    return attrs
  }

  func textAttributes(
    syntax: Markdown.Syntax,
    role: StyleRole,
  ) -> TextAttributes {
    let token = styleToken(for: syntax, role: role)
    return textAttributes(for: token)
  }

  func defaultToken(for role: StyleRole) -> StyleToken {
    switch role {
      case .content: StyleToken(colour: .primary)
      case .syntax: StyleToken(colour: .tertiary)
      case .metadata: StyleToken(colour: .secondary)
    }
  }
}
