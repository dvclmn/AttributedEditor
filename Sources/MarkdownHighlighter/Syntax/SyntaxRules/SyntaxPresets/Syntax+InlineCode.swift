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

        switch path {

          case \.0:
            attrs.update(.font, with: font, in: range)
            attrs.update(
              .backgroundColor,
              with: ThemeColour.olive,
              in: range
            )

          case \.leading,
            \.trailing:
            attrs.update(.foregroundColor, with: NSColor.gray, in: range)

          case \.content:

            attrs.update(
              .foregroundColor,
              with: ThemeColour.reddish, in: range)

          default: return
        }

      }
    }
  }
}
