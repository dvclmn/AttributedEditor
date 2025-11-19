//
//  Syntax+HorizontalRule.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension Markdown.SyntaxRule where T == RegexShape.Single {
  static func horizontalRule() -> Self {

    let pattern = /\n---+?/
    let syntax: Markdown.Syntax = .horizontalRule

    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      exposesBlockRange: false
    )
  }
}
