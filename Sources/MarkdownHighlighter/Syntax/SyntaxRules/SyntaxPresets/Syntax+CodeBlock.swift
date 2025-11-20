//
//  Syntax+CodeBlock.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension Markdown.SyntaxRule where T == RegexShape.CodeBlock {
  
  static var codeBlock: Self {
    
    let pattern = /(?<start>```[ \t]*)(?<langHint>[^\n]*)\n(?<content>(?:.|\n)*?)(?<end>^```[ \t]*$)/
      .dotMatchesNewlines()
      .anchorsMatchLineEndings()
    let syntax: Markdown.Syntax = .codeBlock
    
    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      exposesBlockRange: true,
    )
  }
}
  
//  public static func fencedCodeBlock(codeFont: NSFont) -> SyntaxRule {
//    SyntaxRule(
//      syntax: .codeBlock,
//      delimiter: .fenced(start: "```", end: "```"),
//      role: .blockText,
//      captures: .two(name1: "lang", name2: "body"),
//      regexOptions: [.anchorsMatchLines],
//      exposesBlockRange: true,
//      apply: { match, text, attributes in
//        let fullRange = match.range(at: 0)
//        let langRange = match.range(named: "lang")
//        let bodyRange = match.range(named: "body")
//
//        attributes[fullRange] = [
//          .font: codeFont,
//          .foregroundColor: NSColor.secondaryLabelColor,
//        ]
//        if langRange.location != NSNotFound {
//          attributes[langRange] = [
//            .font: codeFont,
//            .foregroundColor: NSColor.tertiaryLabelColor,
//          ]
//        }
//        if bodyRange.location != NSNotFound {
//          attributes[bodyRange] = [
//            .font: codeFont,
//            .foregroundColor: NSColor.textColor,
//          ]
//        }
//      }
//    )
//  }




//}
