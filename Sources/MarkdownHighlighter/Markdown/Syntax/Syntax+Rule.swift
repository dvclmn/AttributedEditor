//
//  Syntax+Preset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import Foundation
import AppKit

extension SyntaxRule {
  static func fencedCodeBlock() -> SyntaxRule {
    SyntaxRule(
      syntax: .codeBlock,
      delimiter: .fenced(start: "```", end: "```"),
      role: .blockBody(name: "body"),
      captures: .two(name1: "lang", name2: "body"),
      regexOptions: [.anchorsMatchLines],
      apply: { match, text, attributes in
        let full = match.range(at: 0)
        let lang  = match.range(withName: "lang")
        let body  = match.range(withName: "body")
        
        attributes[full] = [
          .foregroundColor: NSColor.secondaryLabelColor,
          .font: codeFont
        ]
        
        if lang.location != NSNotFound {
          attributes[lang] = [.foregroundColor: NSColor.tertiaryLabelColor]
        }
        
        if body.location != NSNotFound {
          attributes[body] = [.foregroundColor: NSColor.textColor]
        }
      }
    )
  }
  
  static func heading(level: Int) -> SyntaxRule {
    let prefix = String(repeating: "#", count: level) + " "
    return SyntaxRule(
      syntax: Markdown.Syntax(rawValue: "heading\(level)")!,
      delimiter: .prefix(prefix),
      role: .inlineText,
      captures: .single(name: "content"),
      regexOptions: [.anchorsMatchLines],
      apply: { match, text, attributes in
        let content = match.range(withName: "content")
        attributes[match.range] = [
          .font: NSFont.systemFont(ofSize: 22 - CGFloat(level)*1.5,
                                   weight: .bold)
        ]
      }
    )
  }
}
