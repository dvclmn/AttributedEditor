//
//  Syntax+InlineCode.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit
import CoreTools

extension SyntaxRule {
  static func inlineCode(fontSize: CGFloat) -> SyntaxRule {
//    let captureName: String = "code"
    
    return SyntaxRule(
      syntax: .inlineCode,
      pattern: /(?<leading>`)(?<content>[^`\n]+?)(?<trailing>`)(?!`)/
//      delimiter: .wrapper(prefix: "`", suffix: "`"),
//      role: .inlineText,
//      captures: .single(name: captureName)
    ) { match, text, attrs in
      
//      guard let range = match.range.toNSRange(in: text) else { return }
      let range = match.range.toNSRange(in: text)
      
      attrs[range]?[.font] = NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
      attrs[range]?[.foregroundColor] = NSColor.systemOrange
      
//      guard let range = match.range(withName: captureName).toOptional() else { return }
    }
  }


}
