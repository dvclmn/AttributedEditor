//
//  Syntax+InlineCode.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension SyntaxRule where T == RegexShape.Three {
  static func inlineCode(
    fontSize: CGFloat,
    theme: Markdown.Theme,
  ) -> SyntaxRule {

    let pattern = /(?<leading>`)(?<content>(?:[^`\n])+?)(?<trailing>`)/
    let syntax: Markdown.Syntax = .inlineCode

    //    let syntaxCol = theme.colourPair(for: syntax, component: .syntax)
    //    let contentCol = theme.colourPair(for: syntax, component: .content)

    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      theme: theme,
      exposesBlockRange: false
    ) {
      match,
      text,
      attrs in

      pattern.apply(
        match: match,
      ) {
        path,
        range in
        let font = NSFont.system(.body, size: fontSize * 0.97, monospaced: true)
        attrs.updating(.font, with: font, in: range)

        switch path {

          case \.0:
            attrs.updating(
              .backgroundColor,
              with: Colour.hsv(
                h: 0.34,
                s: 0.17,
                v: 0.2
              ).nsColor(),
              in: range
            )
          //          case \.leading:
          case \.leading,
            \.trailing:
            attrs.updating(.foregroundColor, with: NSColor.gray, in: range)
          //            attrs.updating(.backgroundColor, with: syntaxCol.bg, in: range)

          case \.content:

            attrs.updating(
              .foregroundColor,
              with: Colour.hsv(
                h: 0.02,
                s: 0.69,
                v: 0.82
              ).nsColor(), in: range)

          //            attrs.updating(.backgroundColor, with: contentCol.bg, in: range)

          default: return
        }

      }
    }
  }
}
