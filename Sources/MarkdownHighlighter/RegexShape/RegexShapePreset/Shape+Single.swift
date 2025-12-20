//
//  Shape+Single.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import Foundation
import HighlighterCommon

extension SyntaxRule where T == RegexShape.Single {

  func apply(
    match: Regex<T>.Match,
    theme: Markdown.Theme,
    attrs: inout AttributedRanges
  ) {

    precondition(
      syntax.regexShape == .single,
      "Only syntaxes with RegexShape of .wrap are valid here."
    )
    let range = match.range
    attrs.update(.fore(.systemPink), in: range, tag: "Shape.Single Whole")

  }

}
