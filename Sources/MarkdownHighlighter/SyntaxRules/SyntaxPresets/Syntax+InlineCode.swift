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
      pattern: Regex(pattern)
    ) { match, text, attrs in

      guard let output = match.output.extractValues(as: outputType),
        let rangeContent = text.range(of: output.content)?.toNSRange(in: text)
      else {
        print("Failed to extract Values, or find content range")
        return
      }

      //      DisplayString {
      //        Indented("Output") {
      //          Labeled("Leading", value: output.leading)
      //          Labeled("Content", value: output.content)
      //          Labeled("Trailing", value: output.trailing)
      //        }
      //        Labeled("NSRange", value: rangeContent.description)
      //      }.print()

      attrs[rangeContent, default: [:]][.font] = NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
      attrs[rangeContent, default: [:]][.foregroundColor] = NSColor.systemOrange
    }
  }
}
