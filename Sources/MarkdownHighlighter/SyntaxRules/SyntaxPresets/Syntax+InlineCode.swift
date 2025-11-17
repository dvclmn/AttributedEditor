//
//  Syntax+InlineCode.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit

extension SyntaxRule {
  static func inlineCode(fontSize: CGFloat) -> SyntaxRule {
//    let captureName: String = "code"
    
    return SyntaxRule(
      syntax: .inlineCode,
      pattern: /(?<leading>`)(?<content>[^`\n]+?)(?<trailing>`)(?!`)/
//      delimiter: .wrapper(prefix: "`", suffix: "`"),
//      role: .inlineText,
//      captures: .single(name: captureName)
    ) { match, attrs in
      guard let range = match.range(withName: captureName).toOptional() else { return }
      attrs[range, default: [:]][.font] = NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
      attrs[range, default: [:]][.foregroundColor] = NSColor.systemOrange
    }
  }


}
