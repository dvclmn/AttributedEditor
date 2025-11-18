//
//  Syntax+InlineCode.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit
import CoreTools

extension SyntaxRule where T == RegexShape.Three {
  static func inlineCode(fontSize: CGFloat) -> SyntaxRule {

    let pattern = /(?<leading>`)(?<content>[^`\n]+?)(?<trailing>`)(?!`)/

    return SyntaxRule(
      syntax: .inlineCode,
      pattern: pattern,
      exposesBlockRange: true
    ) {
      match,
      text,
      attrs in

      pattern.apply(
        match: match,
        in: text,
        for: \.leading, \.content, \.trailing
      ) { path, range in
        let font = NSFont.system(.body, size: fontSize, monospaced: true)
        attrs.updating(.font, with: font, in: range)

        switch path {
//          case \.leading:
//            attrs.updating(.foregroundColor, with: NSColor.green, in: range)

          case \.content:
            attrs.updating(.foregroundColor, with: NSColor.systemOrange, in: range)

          case \.trailing:
            attrs.updating(.foregroundColor, with: NSColor.systemPink, in: range)

          default: break
        }

      }
      //      guard let range = NSRange(
      //        from: match,
      //        as: RegexShape.three,
      //        keyPath: \.content,
      //        in: text
      //      ) else { return }
      //
      //      let font = NSFont.system(.body, size: fontSize, monospaced: true)
      //
      //      attrs.updating(.font, with: font, in: range)
      //      attrs.updating(.foregroundColor, with: NSColor.systemOrange, in: range)

    }
  }
}
