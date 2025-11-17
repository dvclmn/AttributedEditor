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
    ) {
      match,
      text,
      attrs in
      
      //      guard let range = match.range.toNSRange(in: text) else { return }
      guard let output = match.output.extractValues(
        as: (
          Substring,
          leading: Substring,
          content: Substring,
          trailing: Substring
        ).self
      ) else {
        print("Couldn't extract strongly typed values from match")
        return
      }
      
      let rangeLeading = Range(output.leading.indices).toNSRange(in: text)
        
//        .range.toNSRange(in: text)
      
      attrs[rangeLeading]?[.font] = NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
      attrs[rangeLeading]?[.foregroundColor] = NSColor.systemOrange
      
    }
  }


}
