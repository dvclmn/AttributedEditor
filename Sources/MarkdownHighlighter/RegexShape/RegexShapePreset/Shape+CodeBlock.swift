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
    let contentToken = theme.style(for: syntax, part: .content)
    let metaToken = theme.style(for: syntax, part: .meta)

    let syntaxTraits = syntaxToken.font ?? []
    let contentTraits = contentToken.font ?? []

    let syntaxColour = syntaxToken.nsColour
    let metaColour = metaToken.nsColour
    //    let contentFont = theme.style(
    //      for: syntax,
    //      part: .content
    //    ).nsFont(fontSize)

    let contentColour = theme.style(for: syntax, part: .content).nsColour
    let bgColour = theme.style(for: syntax, part: .bg).nsColour

    self.pattern.apply(match: match) {
      path,
      range in

      switch path {
        case \.0:

          attrs.update(
            .init(bgOptional: bgColour),
            in: range,
            tag: "Code Block whole"
          )

        case \.start, \.end:
          attrs.update(
            .init(foreOptional: syntaxColour),
            in: range,
            tag: "Code Block Start"
          )
          attrs.update(
            .fontTraits(syntaxTraits),
            //            .init(fontTraits: syntaxTraits),
            //            .init(font: syntaxFont),
            in: range,
            tag: "Code Block Start"
          )

        case \.langHint:
          attrs.update(
            .init(foreOptional: metaColour),
            in: range,
            tag: "Code Block Language hint"
          )

        case \.content:
          attrs.update(
            .fontTraits(contentTraits),
            //            .init(font: contentFont),
            in: range,
            tag: "Code Block Content"
          )
          attrs.update(
            .init(foreOptional: contentColour), in: range, tag: "Code Block Content")

        default: break
      }
    }
  }
}
