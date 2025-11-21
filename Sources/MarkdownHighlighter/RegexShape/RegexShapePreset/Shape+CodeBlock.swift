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
//    fontSize: CGFloat,
    attrs: inout AttributedRanges
  ) {
    precondition(
      syntax.regexShape == .codeBlock,
      "Only syntaxes with RegexShape of \(syntax.regexShape) are valid here."
    )

    let syntaxToken = theme.style(for: syntax, part: .syntax)
    
    let syntaxFont = syntaxToken.nsFont
    let syntaxColour = syntaxToken.nsColour

    let contentFont = theme.style(
      for: syntax,
      part: .content
    ).nsFont

    let contentColour = theme.style(for: syntax, part: .content).nsColour
    let bgColour = theme.style(for: syntax, part: .bg).nsColour

    self.pattern.apply(match: match) {
      path,
      range in

      switch path {
        case \.0:

          attrs.update(
            .init(bg: bgColour),
            in: range,
            tag: "Code Block whole"
          )

        case \.start, \.end:
          attrs.update(
            .init(fore: syntaxColour),
            in: range,
            tag: "Code Block Start"
          )
          attrs.update(
            .init(font: syntaxFont),
            in: range,
            tag: "Code Block Start"
          )

        case \.langHint:
          attrs.update(
            .init(fore: theme.style(for: syntax, part: .meta).nsColour), in: range,
            tag: "Code Block Language hint")

        case \.content:
          attrs.update(
            .init(font: contentFont),
            in: range,
            tag: "Code Block Content"
          )
          attrs.update(.init(fore: contentColour), in: range, tag: "Code Block Content")

        default: break
      }
    }
  }
}
