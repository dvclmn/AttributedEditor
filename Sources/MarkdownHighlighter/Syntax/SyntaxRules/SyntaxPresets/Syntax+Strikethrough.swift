//
//  Syntax+Strikethrough.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension SyntaxRule where T == RegexShape.Three {
  static func strikethrough(
    fontSize: CGFloat,
    theme: Markdown.Theme,
  ) -> SyntaxRule {

    let pattern = /(?<leading>(?:\~{2}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/
    let syntax: Markdown.Syntax = .strikethrough

    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      theme: theme,
      exposesBlockRange: false
    ) { match, attrs in

      pattern.apply(match: match) { path, range in
        switch path {

          case \.leading, \.trailing:
            attrs.update(.foregroundColor, with: ThemeColour.syntaxColour, in: range)

          case \.content:
            attrs.update(.foregroundColor, with: NSColor.secondaryLabelColor, in: range)
            attrs.update(.strikethroughColor, with: NSColor.systemRed, in: range)
            attrs.update(.strikethroughStyle, with: NSUnderlineStyle.single.rawValue, in: range)

          default: return
        }
      }
    }
  }
}
