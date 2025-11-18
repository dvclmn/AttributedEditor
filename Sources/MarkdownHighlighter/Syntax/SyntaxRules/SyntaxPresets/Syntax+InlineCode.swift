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
    
//    let syntaxColour: NSColor = theme.colour(for: syntax, type: .fg)
    
//    let fg = theme.colour(for: syntax, type: .fg)
//    let bg = theme.colour(for: syntax, type: .bg)
    
    let syntaxFore = theme.colour(
      for: syntax,
      component: .syntax,
      type: .fg
    )
    let syntaxBG = theme.colour(
      for: syntax,
      component: .syntax,
      type: .bg
    )
    let contentFore = theme.colour(
      for: syntax,
      component: .content,
      type: .fg
    )
    let contentBG = theme.colour(
      for: syntax,
      component: .content,
      type: .bg
    )
    
    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      theme: theme,
      exposesBlockRange: false
//      exposesBlockRange: true
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
          case \.leading, \.trailing:
            attrs.updating(.foregroundColor, with: synt, in: range)


          case \.content:
            attrs.updating(.foregroundColor, with: fg, in: range)

//          case \.trailing:
//            attrs.updating(.foregroundColor, with: bg, in: range)

          default: return
        }

      }
    }
  }
}
