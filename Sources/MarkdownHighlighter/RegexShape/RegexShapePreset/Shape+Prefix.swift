//
//  SyntaxRule+ShapePreset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import HighlighterCommon

extension SyntaxRule where T == RegexShape.Prefix {
  func apply(
    match: Regex<T>.Match,
    theme: Markdown.Theme,
//    fontSize: CGFloat,
    attrs: inout NSAttributedRanges
  ) {
    
  }
}
//
//  func apply(
//    match: Regex<T>.Match,
//    theme: Markdown.Theme,
//    attrs: inout AttributedRanges
//  ) {
//    
//    precondition(syntax.regexShape == .wrap, "Only syntaxes with RegexShape of .wrap are valid here.")
//    
//    self.pattern.apply(
//      match: match,
//    ) {
//      path,
//      range in
//      
//      let colours = self.colours(for: syntax, theme: theme)
//      switch path {
//        case \.leading:
//          attrs.update(.foreground(colours.syntax), in: range)
//          
//        case \.trailing:
//          attrs.update(.foreground(colours.syntax), in: range)
//          
//        case \.content:
//          /// I think striekthrough is the only special case here
//          if syntax == .strikethrough {
//            attrs.update(
//              .strikethroughColor,
//              with: theme.strikeLine.nsColor(fallback: NSColor.red),
//              in: range
//            )
//            attrs.update(
//              .strikethroughStyle,
//              with: NSUnderlineStyle.single.rawValue,
//              in: range
//            )
//          } else {
//            attrs.update(.foreground(colours.content), in: range)
//            
//          }
//          
//        default: return
//      }
//    }
//  }
//  
//  private func colours(
//    for syntax: Markdown.Syntax,
//    theme: Markdown.Theme
//  ) -> (syntax: NSColor, content: NSColor) {
//    
//    let syntaxColour =
//    theme.colour(
//      for: self.syntax,
//      kind: .syntaxChar,
//      fallback: ThemeColour.syntaxColourFallback
//    )
//    
//    let contentColour = theme.colour(
//      for: syntax,
//      kind: .content,
//      fallback: ThemeColour.contentColourFallback
//    )
//    return (syntaxColour, contentColour)
//    
//  }
//}
