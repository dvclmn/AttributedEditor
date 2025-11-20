//
//  Shape+CodeBlock.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import CoreTools
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

    let syntaxFont = theme.style(for: syntax, part: .syntaxLeading)
      .nsFont(fontSize)
    let syntaxColour = theme.style(for: syntax, part: .syntaxLeading)
      .nsColour

    let contentFont = theme.style(for: syntax, part: .content).nsFont(
      fontSize
    )
    let contentColour = theme.style(for: syntax, part: .content).nsColour

    let bgColour = theme.style(for: syntax, part: .background).nsColour

    self.pattern.apply(match: match) { path, range in

      switch path {
        case \.0:

          attrs.update(.init(background: bgColour), in: range, tag: "Code Block whole")

        //          attrs.update(Attribute(background: theme.style(for: syntax, part: .background).nsColour), in: range)
        //          attrs.update(Attribute(background: syntax.colour(for: .background)), in: range)
        //          attrs.update(Attribute(font: syntax.font(ofSize: fontSize, for: .content)), in: range)

        case \.start:

          attrs.update(.init(foreground: syntaxColour), in: range, tag: "Code Block Start")
          attrs.update(.init(font: syntaxFont), in: range, tag: "Code Block Start")

        //          attrs.update(Attribute(foreground: theme.style(for: syntax, part: .syntaxLeading).nsColour), in: range)
        //
        //          attrs.update(Attribute(font: theme.style(for: syntax, part: .syntaxLeading).nsFont(fontSize)), in: range)

        case \.langHint:
          //          attrs.update(Attribute(foreground: syntax.colour(for: .languageHint)), in: range)
          attrs.update(.init(foreground: theme.style(for: syntax, part: .metadata).nsColour), in: range, tag: "Code Block Language hint")
        //          attrs.update(.init(font: syntaxFont), in: range)
        //          attrs.update(Attribute(foreground: theme.style(for: syntax, part: .metadata).nsColour), in: range)

        case \.content:
          //          attrs.update(.init(foreground: syntaxColour), in: range)
          attrs.update(.init(font: contentFont), in: range, tag: "Code Block Content")
          attrs.update(.init(foreground: contentColour), in: range, tag: "Code Block Content")

        case \.end:
          attrs.update(.init(foreground: syntaxColour), in: range, tag: "Code Block End")
        //          attrs.update(.init(font: syntaxFont), in: range)
        //          attrs.update(Attribute(foreground: syntax.colour(for: .syntaxChar)), in: range)
        //          attrs.update(Attribute(foreground: theme.style(for: syntax, part: .syntaxTrailing).nsColour), in: range)
        //          attrs.update(Attribute(font: syntax.font(ofSize: fontSize, for: .syntaxChar)), in: range)
        //          attrs.update(Attribute(font: theme.style(for: syntax, part: .syntaxTrailing).nsFont(fontSize)), in: range)

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
