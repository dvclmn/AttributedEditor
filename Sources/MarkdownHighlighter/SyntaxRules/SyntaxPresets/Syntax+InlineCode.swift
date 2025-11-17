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

    let outputType = (
      Substring,
      leading: Substring,
      content: Substring,
      trailing: Substring
    ).self

    return SyntaxRule(
      syntax: .inlineCode,
      pattern: Regex(pattern),
      exposesBlockRange: true
    ) { match, text, attrs in

      guard let output = match.output.extractValues(as: outputType),
        let rangeContent = text.range(of: output.content)?.toNSRange(in: text)
      else {
        print("Failed to extract Values, or find content range")
        return
      }

      let ranges: [NSRange]
      
      //      DisplayString {
      //        Indented("Output") {
      //          Labeled("Leading", value: output.leading)
      //          Labeled("Content", value: output.content)
      //          Labeled("Trailing", value: output.trailing)
      //        }
      //        Labeled("NSRange", value: rangeContent.description)
      //      }.print()

      attrs.updating(.font, with: NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular), in: rangeContent)
      attrs.updating(.foregroundColor, with: NSColor.systemOrange, in: rangeContent)

    }
  }
}
