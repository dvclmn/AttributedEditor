//
//  Syntax+Thingy.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import Foundation
import HighlighterCommon

extension Markdown {
  public struct StyleLibrary: Sendable {
    let theme: Theme
        let fontSize: CGFloat

    public init(
      theme: Theme,
            fontSize: CGFloat
    ) {
      self.theme = theme
            self.fontSize = fontSize
    }
  }
}

extension Markdown.StyleLibrary {

  static var wrapRules: [SyntaxRule<RegexShape.Wrap>] {
    [
      SyntaxRule.bold(),
      SyntaxRule.italic(),
      SyntaxRule.boldItalic(),
    ]
  }

  static var singleRules: [SyntaxRule<RegexShape.Single>] {
    [
      SyntaxRule.horizontalRule()
    ]
  }

  func applyAttributes(
    to text: String,
    attributes: inout AttributedRanges
  ) {
    for rule in Self.wrapRules {
      let matches = text.matches(of: rule.pattern)
      for match in matches {
        rule.applyWrap(
          match: match,
          theme: self.theme,
          fontSize: fontSize,
          attrs: &attributes
        )
      }
    }

    for rule in Self.singleRules {
      let matches = text.matches(of: rule.pattern)
      for match in matches {
        rule.applySingle(
          match: match,
          theme: self.theme,
          fontSize: fontSize,
          attrs: &attributes
        )
      }
    }
  }
}
