//
//  Syntax+BoldItalic.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension Markdown.SyntaxRule where T == RegexShape.Wrap {
  static func bold(
    fontSize: CGFloat,
    theme: Markdown.Theme,
    apply: SyntaxOutput<T>
  ) -> Self {

    let pattern = /(?<leading>(?:\*{2}|_{2}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/
    let syntax: Markdown.Syntax = .bold

    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
//      theme: theme,
      exposesBlockRange: false,
      apply: apply
    )
  }

  static func italic(
//    fontSize: CGFloat,
//    theme: Markdown.Theme,
  ) -> Self {

    let pattern = /(?<leading>[\*_])(?<content>[^\*_ \n][^\n]*?[^\*_ \n])(?<trailing>\k<leading>)/
    let syntax: Markdown.Syntax = .italic

    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
//      theme: theme,
      exposesBlockRange: false
    ) { match, attrs in

      pattern.apply(
        match: match,
      ) {
        path,
        range in

        let font = NSFont.system(.italic, size: fontSize)

        switch path {

          case \.leading,
            \.trailing:
            attrs.update(.font, with: NSFont.system(.body, size: fontSize * 0.9, monospaced: true), in: range)
            attrs.update(.foregroundColor, with: ThemeColour.syntaxColour, in: range)

          case \.content:
            attrs.update(.font, with: font, in: range)

          default: return
        }

      }
    }
  }

  static func boldItalic(
    fontSize: CGFloat,
    theme: Markdown.Theme,
  ) -> Self {

    let pattern = /(?<leading>(?:\*{3}|_{3}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/
    let syntax: Markdown.Syntax = .boldItalic

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

        let font = NSFont.system(.boldItalic, size: fontSize)

        switch path {

          case \.leading,
            \.trailing:
            attrs.update(.font, with: NSFont.system(.body, size: fontSize * 0.9, monospaced: true), in: range)
            attrs.update(.foregroundColor, with: ThemeColour.syntaxColour, in: range)

          case \.content:
            attrs.update(.font, with: font, in: range)

          default: return
        }

      }
    }
  }
}
