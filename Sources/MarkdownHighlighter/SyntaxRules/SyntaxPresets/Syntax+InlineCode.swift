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

    let pattern = /(?<leading>`)(?<content>[^`\n]+?)(?<trailing>`)(?!`)/

    return SyntaxRule(
      syntax: .inlineCode,
      pattern: Regex(pattern),
      exposesBlockRange: true
    ) { match, text, attrs in
      
      guard let range = NSRange(
        from: match,
        as: RegexShape.three,
        keyPath: \.content,
        in: text
      ) else { return }
      
      let font = NSFont.italic(.preferredFont(.body))
      
      attrs.updating(.font, with: font, in: range)

//      guard let output = match.output.extractValues(as: RegexShape.threePreset),
//        let rangeContent = text.range(of: output.content)?.toNSRange(in: text)
//      else { return }

      attrs.updating(.font, with: NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular), in: range)
      attrs.updating(.foregroundColor, with: NSColor.systemOrange, in: range)

    }
  }
}
