//
//  Syntax+InlineCode.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension Markdown.SyntaxRule where T == RegexShape.Three {
  static func inlineCode(
    fontSize: CGFloat,
    theme: Markdown.Theme,
  ) -> Self {

    let pattern = /(?<leading>`)(?<content>(?:[^`\n])+?)(?<trailing>`)/
    let syntax: Markdown.Syntax = .inlineCode

    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      theme: theme,
      exposesBlockRange: false
    ) { match, attrs in

      pattern.apply(
        match: match,
      ) {
        path,
        range in
        let font = NSFont.system(.body, size: fontSize * 0.97, monospaced: true)

        switch path {

          case \.0:
            attrs.update(.font, with: font, in: range)
            attrs.update(
              .backgroundColor,
              with: NSColor.gray.opacity(0.15),
              //              with: CodableColour.hsv(h: 0.2, s: 0.05, v: 0.1).nsColor(),
              //              with: ThemeColour.olive,
              in: range
            )

          case \.leading,
            \.trailing:
            attrs.update(.foregroundColor, with: ThemeColour.syntaxColour, in: range)

          case \.content:

            attrs.update(.foregroundColor, with: NSColor.secondaryLabelColor, in: range)
//            attrs.update(.foregroundColor, with: CodableColour.hsv(h: 0.4, s: 0.03, v: 0.6).nsColor(), in: range)
          //            attrs.update(.foregroundColor, with: ThemeColour.reddish, in: range)

          default: return
        }

      }
    }
  }
}
