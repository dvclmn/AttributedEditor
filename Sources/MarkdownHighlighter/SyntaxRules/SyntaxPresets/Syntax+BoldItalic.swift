//
//  Syntax+BoldItalic.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import CoreTools

extension SyntaxRule {
  static func bold(fontSize: CGFloat) -> SyntaxRule {
    
    let pattern = /(?<leading>\*\*)(?<content>[^\*\*\n]+?)(?<trailing>\*\*)(?!\*)/
    
    let outputType = (
      Substring,
      leading: Substring,
      content: Substring,
      trailing: Substring
    ).self
    
    return SyntaxRule(
      syntax: .inlineCode,
      pattern: Regex(pattern)
    ) { match, text, attrs in
      
      guard let output = match.output.extractValues(as: outputType),
            let rangeContent = text.range(of: output.content)?.toNSRange(in: text)
      else {
        print("Failed to extract Values, or find content range")
        return
      }

      attrs[rangeContent, default: [:]][.font] = NSFont.boldSystemFont(ofSize: fontSize)
//      attrs[rangeContent, default: [:]][.foregroundColor] = NSColor.systemOrange
    }
  }
}

//@MainActor
//extension SyntaxRule {

//  static func bold(fontSize: CGFloat) -> SyntaxRule {
//    SyntaxRule(
//      syntax: .bold,
//      pattern: /(?<code>\*\*)/,
//      delimiter: .wrapper(prefix: "**", suffix: "**"),
//      role: .inlineText,
//      captures: .single(name: "body"),
//    ) { match, attrs in
//      
////      let thing = match.output.extractValues(as: )
//      
////      guard let range = match.range(withName: "body").toOptional() else { return }
////      attrs[range, default: [:]][.font] = NSFont.boldSystemFont(ofSize: fontSize)
//    }
//  }
//
//  static func italic(fontSize: CGFloat) -> SyntaxRule {
//    SyntaxRule(
//      syntax: .italic,
//      delimiter: .wrapper(prefix: "*", suffix: "*"),
//      role: .inlineText,
//      captures: .single(name: "body")
//    ) { match, attrs in
//      
//      guard let range = match.range(withName: "body").toOptional() else { return }
//      let base = NSFont.systemFont(ofSize: fontSize)
//      attrs[range, default: [:]][.font] =
//        NSFontManager.shared.convert(base, toHaveTrait: .italicFontMask)
//    }
//  }

//}
