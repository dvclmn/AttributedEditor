//
//  Shape+CodeBlock.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import HighlighterCommon

extension SyntaxRule where T == RegexShape.CodeBlock {
  func apply(
    match: Regex<T>.Match,
    theme: Markdown.Theme,
    fontSize: CGFloat,
    attrs: inout AttributedRanges
  ) {
    precondition(
      syntax.regexShape == .codeBlock,
      "Only syntaxes with RegexShape of \(syntax.regexShape) are valid here."
    )

    self.pattern.apply(match: match) { path, range in

      switch path {
        case \.0:
          attrs.update(.font(<#T##NSFont#>), in: <#T##Range<String.Index>#>)
          
        case \.start:
          
          
        case \.langHint:
          
          
        case \.content:
          
          
        case \.end:
          
          
        default: break
      }
      //      let colours = self.colours(for: syntax, theme: theme)
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
      //
      //      switch path {
      //        case \.leading:
      //          if let syntaxFont {
      //            attrs.update(.font(syntaxFont), in: range)
      //          }
      //          attrs.update(.foreground(colours.syntax), in: range)
      //
      //        case \.trailing:
      //          if let syntaxFont {
      //            attrs.update(.font(syntaxFont), in: range)
      //          }
      //          attrs.update(.foreground(colours.syntax), in: range)
      //
      //        case \.content:
      //          if let contentFont {
      //            attrs.update(.font(contentFont), in: range)
      //          }
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
      //
      //        default: return
      //      }
    }
  }
}
