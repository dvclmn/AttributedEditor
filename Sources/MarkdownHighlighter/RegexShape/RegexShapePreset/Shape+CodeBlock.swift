//
//  Shape+CodeBlock.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

extension Markdown.SyntaxRule {
//extension SyntaxRule where T == RegexShape.CodeBlock {
  func apply(
    match: AnyRegex.Match,
//    theme: Markdown.Theme,
    attrs: inout NSAttributedRanges
  ) {
    precondition(
      syntax.regexShape == .codeBlock,
      "Only syntaxes with RegexShape of \(syntax.regexShape) are valid here."
    )

    let syntaxToken = theme.style(for: syntax, part: .syntax)
    let contentToken = theme.style(for: syntax, part: .content)
    let metaToken = theme.style(for: syntax, part: .meta)

    let syntaxTraits = syntaxToken.fontTraits ?? []
    let contentTraits = contentToken.fontTraits ?? []
    
    let bgColour = theme.style(for: syntax, part: .bg).nsColour

//    if let patt = self.
    
    self.pattern.processMatch(match) {
      path,
      range in

      switch path {
        case \.0:
/// I think it will be worth running this for each syntax/part? And only process if a value is present?
          attrs.update(
            .init(bgOptional: bgColour),
            in: range,
            tag: "Code Block whole"
          )

        case \.start, \.end:
          attrs.update(
            .init(foreOptional: syntaxToken.nsColour),
            in: range,
            tag: "Code Block Start"
          )
          attrs.update(
            .fontTraits(syntaxTraits),
            in: range,
            tag: "Code Block Start"
          )

        case \.langHint:
          attrs.update(
            .init(foreOptional: metaToken.nsColour),
            in: range,
            tag: "Code Block Language hint"
          )

        case \.content:
          attrs.update(
            .fontTraits(contentTraits),
            in: range,
            tag: "Code Block Content"
          )
          attrs.update(
            .init(foreOptional: contentToken.nsColour),
            in: range,
            tag: "Code Block Content"
          )

        default: break
      }
    }
  }
}
