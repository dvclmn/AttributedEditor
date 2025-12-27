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

extension Markdown {
  public struct Theme: Highlighter.Theme, @unchecked Sendable {
    var styleDefinitions: [AnyHashable: StyleTokens] = [:]
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

}
