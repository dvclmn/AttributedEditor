//
//  Syntax+InlineCode.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit

extension SyntaxRule {
  static func inlineCode(fontSize: CGFloat) -> SyntaxRule {
    SyntaxRule(
      syntax: .inlineCode,
      delimiter: .wrapper(prefix: "`", suffix: "`"),
      role: .inlineText,
      captures: .single(name: "code")
    ) { match, text, attrs in
      guard let range = match.range(withName: "code").toOptional() else { return }
      attrs[range, default: [:]][.font] = NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
      attrs[range, default: [:]][.foregroundColor] = NSColor.systemOrange
    }
  }


}
