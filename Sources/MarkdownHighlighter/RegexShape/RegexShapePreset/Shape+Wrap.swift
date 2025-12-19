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

    let syntaxToken = theme.style(for: syntax, part: .syntax)
    let contentToken = theme.style(for: syntax, part: .content)

    let syntaxTraits = syntaxToken.font
    let syntaxColour = syntaxToken.nsColour

    let contentTraits = contentToken.font
    //    let contentFont = theme.style(for: syntax, part: .content).nsFont(fontSize)
    let contentColour = contentToken.nsColour

    let bgColour = theme.style(for: syntax, part: .bg).nsColour

    self.pattern.apply(match: match) {
      path,
      range in

      //      let colours = self.colours(for: syntax, theme: theme)

      switch path {

        case \.0:
          //          break
          attrs.update(
            .init(bgOptional: bgColour),
            in: range,
            tag: "Shape.Wrap whole"
          )

        case \.leading:
          attrs.update(
            .init(foreOptional: syntaxColour), in: range, tag: "Shape.Wrap Leading")
          attrs.update(.init(fontTraitsOptional: syntaxTraits), in: range, tag: "Shape.Wrap Leading")
        //          if let syntaxFont {
        //            attrs.update(.font(syntaxFont), in: range)
        //          }
        //          attrs.update(.foreground(colours.syntax), in: range)

        case \.trailing:
          attrs.update(
            .init(foreOptional: syntaxColour),
            in: range,
            tag: "Shape.Wrap Trailing"
          )
          attrs.update(.init(fontTraitsOptional: syntaxTraits), in: range, tag: "Shape.Wrap Trailing")
        //          if let syntaxFont {
        //            attrs.update(.font(syntaxFont), in: range)
        //          }
        //          attrs.update(.foreground(colours.syntax), in: range)

        case \.content:
          attrs.update(
            .init(foreOptional: contentColour),
            in: range,
            tag: "Shape.Wrap Content"
          )
          attrs.update(.init(fontTraitsOptional: contentTraits), in: range, tag: "Shape.Wrap Content")
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
