//
//  SyntaxRule+ShapePreset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

extension SyntaxRule where T == RegexShape.Wrap {

  func apply(
    match: Regex<T>.Match,
    theme: Markdown.Theme,
//    fontSize: CGFloat,
    attrs: inout AttributedRanges
  ) {

    precondition(
      syntax.regexShape == .wrap,
      "Only syntaxes with RegexShape of .wrap are valid here."
    )

    let syntaxFont = theme.style(for: syntax, part: .syntax).nsFont
    let syntaxColour = theme.style(for: syntax, part: .syntax).nsColour

    let contentFont = theme.style(for: syntax, part: .content).nsFont
    let contentColour = theme.style(for: syntax, part: .content).nsColour

    let bgColour = theme.style(for: syntax, part: .bg).nsColour

    self.pattern.apply(match: match) { path, range in

      //      let colours = self.colours(for: syntax, theme: theme)

      switch path {

        case \.0:
//          break
          attrs.update(.init(bg: bgColour), in: range, tag: "Shape.Wrap whole")

        case \.leading:
          attrs.update(
            .init(fore: syntaxColour), in: range, tag: "Shape.Wrap Leading")
          attrs.update(.init(font: syntaxFont), in: range, tag: "Shape.Wrap Leading")
        //          if let syntaxFont {
        //            attrs.update(.font(syntaxFont), in: range)
        //          }
        //          attrs.update(.foreground(colours.syntax), in: range)

        case \.trailing:
          attrs.update(
            .init(fore: syntaxColour), in: range, tag: "Shape.Wrap Trailing")
          attrs.update(.init(font: syntaxFont), in: range, tag: "Shape.Wrap Trailing")
        //          if let syntaxFont {
        //            attrs.update(.font(syntaxFont), in: range)
        //          }
        //          attrs.update(.foreground(colours.syntax), in: range)

        case \.content:
          attrs.update(
            .init(fore: contentColour), in: range, tag: "Shape.Wrap Content")
          attrs.update(.init(font: contentFont), in: range, tag: "Shape.Wrap Content")
        //          if let contentFont {
        //            attrs.update(.font(contentFont), in: range)
        //          }
        //          /// I think striekthrough is the only special case here
        //          if syntax == .strikethrough {
        //            attrs.update(.strikeColour(<#T##NSColor#>), in: <#T##Range<String.Index>#>)
        ////            attrs.update(
        ////              .strikethroughColor,
        ////              with: theme.strikeLine.nsColor(fallback: NSColor.red),
        ////              in: range
        ////            )
        ////            attrs.update(
        ////              .strikethroughStyle,
        ////              with: NSUnderlineStyle.single.rawValue,
        ////              in: range
        ////            )
        //          }
        //
        //          attrs.update(.foreground(colours.content), in: range)
        //
        //          if let font = NSFont.font(
        //            ofSize: fontSize,
        //            for: syntax,
        //            kind: .content
        //          ) {
        //            attrs.update(.font(font), in: range)
        //          }

        default: return
      }
    }
  }

  //  private func colours(
  //    for syntax: Markdown.Syntax,
  //    theme: Markdown.Theme
  //  ) -> (syntax: NSColor, content: NSColor) {
  //
  //    let syntaxColour =
  //      theme.colour(
  //        for: self.syntax,
  //        kind: .syntaxChar,
  //        fallback: ThemeColour.syntaxColourFallback
  //      )
  //
  //    let contentColour = theme.colour(
  //      for: syntax,
  //      kind: .content,
  //      fallback: ThemeColour.contentColourFallback
  //    )
  //    return (syntaxColour, contentColour)
  //
  //  }
}
