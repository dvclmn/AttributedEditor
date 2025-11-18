//
//  Syntax+HorizontalRule.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension SyntaxRule where T == RegexShape.Single {
  static func horizontalRule(
    fontSize: CGFloat,
    theme: Markdown.Theme,
  ) -> SyntaxRule {

    let pattern = /\n---+?/
    let syntax: Markdown.Syntax = .horizontalRule

    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      theme: theme,
      exposesBlockRange: false
    ) { match, attrs in

      let range = match.range
      let font = NSFont.system(.body, size: fontSize * 0.97, monospaced: true)

      attrs.update(
        .foregroundColor,
        with: ThemeColour.reddish, in: range)
      
    }
  }
}
