//
//  Syntax+InlineCode.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit
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
      exposesBlockRange: true
    ) {
      match,
      text,
      attrs in

      pattern.apply(
        match: match,
        for: \.leading, \.content, \.trailing
      ) { path, range in
        let font = NSFont.system(.body, size: fontSize, monospaced: true)
        attrs.updating(.font, with: font, in: range)

        switch path {
          case \.leading:
            attrs.updating(.foregroundColor, with: theme.colour(for: syntax), in: range)

          case \.content:
            attrs.updating(.foregroundColor, with: theme.colour(for: syntax), in: range)

          case \.trailing:
            attrs.updating(.foregroundColor, with: theme.colour(for: syntax), in: range)

          default: return
        }

      }
    }
  }
}
