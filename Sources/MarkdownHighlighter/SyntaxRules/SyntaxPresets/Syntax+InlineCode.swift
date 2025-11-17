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
    //    let outputType = (
    //      Substring,
    //      leading: Substring,
    //      content: Substring,
    //      trailing: Substring
    //    ).self

    let pattern = /(?<leading>`)(?<content>[^`\n]+?)(?<trailing>`)(?!`)/

    //    let thing = Regex(pattern)
    //
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
      guard let output = match.output.extractValues(as: outputType) else { return }

      guard let rangeContent = text.range(of: output.content)?.toNSRange(in: text) else {
        print("Failed to find content range")
        return
      }
      
      DisplayString {
        Indented("Output") {
          Labeled("Leading", value: output.leading)
          Labeled("Content", value: output.content)
          Labeled("Trailing", value: output.trailing)
        }
        Labeled("NSRange", value: rangeContent.description)
      }.print()
      
//      output.content
      
//      let range = mat
      
//      let nsRange = match.range.toNSRange(in: text)
//      let rangeLeading = Range(output.leading.indices).toNSRange(in: text)
      //
      ////        .range.toNSRange(in: text)
      //
      attrs[rangeContent, default: [:]][.font] = NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
//      attrs[rangeContent]?[.font] = NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
      attrs[rangeContent, default: [:]][.foregroundColor] = NSColor.systemOrange
    }

    //
    //
    //    return SyntaxRule<>(
    //      syntax: .inlineCode,
    //      pattern:
    ////      delimiter: .wrapper(prefix: "`", suffix: "`"),
    ////      role: .inlineText,
    ////      captures: .single(name: captureName)
    //    ) {
    //      match,
    //      text,
    //      attrs in
    //
    //      //      guard let range = match.range.toNSRange(in: text) else { return }
    //      guard let output = match.output.extractValues(
    //        as:
    //      ) else {
    //        print("Couldn't extract strongly typed values from match")
    //        return
    //      }
    //
    //      let rangeLeading = Range(output.leading.indices).toNSRange(in: text)
    //
    ////        .range.toNSRange(in: text)
    //
    //      attrs[rangeLeading]?[.font] = NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
    //      attrs[rangeLeading]?[.foregroundColor] = NSColor.systemOrange
    //
    //    }
  }

}
