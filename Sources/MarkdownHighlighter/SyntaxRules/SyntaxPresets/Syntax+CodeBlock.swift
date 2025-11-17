//
//  Syntax+CodeBlock.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension SyntaxRule {

  static func fencedCodeBlock(fontSize: CGFloat) -> SyntaxRule {
    SyntaxRule(
      syntax: .codeBlock,
      delimiter: .fenced(start: "```", end: "```"),
      role: .blockText,
      captures: .two(name1: "lang", name2: "body"),
      exposesBlockRange: true
    ) { match, text, attrs in
      guard let range = match.range(withName: "body").toOptional() else { return }
      attrs[range, default: [:]][.font] =
      NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
      attrs[range, default: [:]][.foregroundColor] = NSColor.systemBlue
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




}
