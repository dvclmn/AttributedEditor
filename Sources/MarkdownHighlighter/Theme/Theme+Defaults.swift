//
//  Theme+Defaults.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 29/12/2025.
//

import ColourKit
import AppKit

extension MarkdownTheme {

  //  public var font: NSFont { NSFont.systemFont(ofSize: 14) }
  public var textColour: NSColor { .textColor }

  func defaultToken(for role: StyleRole) -> StyleToken {
    switch role {
      case .content: StyleToken(colour: .primary)
      case .syntax: StyleToken(colour: .defaultSyntaxColour, font: .monoSpace, fontScale: 0.94)
      case .metadata: StyleToken(colour: .secondary)
    }
  }
  
  

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

extension CodableColour {
  static var defaultSyntaxColour: CodableColour { .grey(0.3) }
}
