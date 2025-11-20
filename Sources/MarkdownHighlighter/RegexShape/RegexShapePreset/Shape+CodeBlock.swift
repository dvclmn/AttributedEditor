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
  }
}
