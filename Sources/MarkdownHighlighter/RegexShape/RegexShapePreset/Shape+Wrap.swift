//
//  SyntaxRule+ShapePreset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

extension Markdown.SyntaxRule {
  
//  var rules: [Self] {
//    [
//      Self.init(
//        for: .bold,
//        pattern: /(?<leading>(?:\*{2}|_{2}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/,
////        theme: <#T##Markdown.Theme#>,
////        font: <#T##NSFont#>
//      )
//    ]
//  }
//extension SyntaxRule where T == RegexShape.Wrap {

  func apply(
//    _ shape: RegexShape,
    text: String,
//    match: Regex<T>.Match,
//    theme: Markdown.Theme,
    attrs: inout NSAttributedRanges
      //    attrs: inout AttributedRanges
  ) {
    
//    let thing = self.pattern.regex
    for match in text.matches(of: self.pattern) {
      let thing = match.output
      
    }
//    for match in text.matches(of: )

    precondition(
      syntax.regexShape == .wrap,
      "Only syntaxes with RegexShape of .wrap are valid here."
    )

    let syntaxToken = theme.style(for: syntax, part: .syntax)
    let contentToken = theme.style(for: syntax, part: .content)

    let syntaxTraits = syntaxToken.fontTraits
    let contentTraits = contentToken.fontTraits

    let syntaxColour = syntaxToken.nsColour
    let contentColour = contentToken.nsColour

    let bgColour = theme.style(for: syntax, part: .bg).nsColour

    self.pattern.apply(match: match) {
      path,
      range in

      switch path {

        case \.0:
          attrs.update(
            .init(bgOptional: bgColour),
            in: range,
            tag: "Shape.Wrap whole"
          )

        case \.leading:
          attrs.update(
            .init(foreOptional: syntaxColour), in: range, tag: "Shape.Wrap Leading")
          attrs.update(
            .fontTraits(syntaxTraits, current: font), in: range, tag: "Shape.Wrap Leading")

        case \.trailing:
          attrs.update(
            .init(foreOptional: syntaxColour),
            in: range,
            tag: "Shape.Wrap Trailing"
          )
          attrs.update(
            .fontTraits(syntaxTraits, current: font), in: range, tag: "Shape.Wrap Trailing"
          )

        case \.content:
          attrs.update(
            .init(foreOptional: contentColour),
            in: range,
            tag: "Shape.Wrap Content"
          )
          attrs.update(
            .fontTraits(contentTraits, current: font), in: range, tag: "Shape.Wrap Content"
//            .init(fontTraitsOptional: contentTraits), in: range, tag: "Shape.Wrap Content"
          )

        default: return
      }
    }
  }
}
