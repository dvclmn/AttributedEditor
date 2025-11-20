//
//  SyntaxRule+ShapePreset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import HighlighterCommon
import CoreTools

extension SyntaxRule where T == RegexShape.Wrap {

  func apply(
    match: Regex<T>.Match,
    theme: Markdown.Theme,
    fontSize: CGFloat,
    attrs: inout AttributedRanges
  ) {

    precondition(
      syntax.regexShape == .wrap,
      "Only syntaxes with RegexShape of .wrap are valid here."
    )

    self.pattern.apply(match: match) { path, range in

//      let colours = self.colours(for: syntax, theme: theme)
      
      
      let syntaxFont = syntax.font(ofSize: fontSize, for: .syntaxChar)
      let syntaxColour = syntax.colour(for: .syntaxChar)
      
      let contentFont = syntax.font(ofSize: fontSize, for: .content)
      let contentColour = syntax.colour(for: .content)
      
      let bgColour = syntax.colour(for: .background)
 
//      let syntaxFont: NSFont? = .font(
//        ofSize: fontSize,
//        for: syntax,
//        kind: .syntaxChar
//      )
//      let contentFont: NSFont? = .font(
//        ofSize: fontSize,
//        for: syntax,
//        kind: .content
//      )

      switch path {
          
        case \.0:
          attrs.update(.init(background: bgColour), in: range)
          
//          if syntax.isInlineCode {
//            attrs.update(.background(theme.colour(for: .inlineCode, kind: .background, fallback: <#T##NSColor#>)), in: <#T##Range<String.Index>#>)
//          }
          
        case \.leading:
          attrs.update(.init(foreground: syntaxColour), in: range)
          attrs.update(.init(font: syntaxFont), in: range)
//          if let syntaxFont {
//            attrs.update(.font(syntaxFont), in: range)
//          }
//          attrs.update(.foreground(colours.syntax), in: range)

        case \.trailing:
          attrs.update(.init(foreground: syntaxColour), in: range)
          attrs.update(.init(font: syntaxFont), in: range)
//          if let syntaxFont {
//            attrs.update(.font(syntaxFont), in: range)
//          }
//          attrs.update(.foreground(colours.syntax), in: range)

        case \.content:
          attrs.update(.init(foreground: contentColour), in: range)
          attrs.update(.init(font: contentFont), in: range)
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
