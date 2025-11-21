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

  //  public var blockRangeRules: [RegexShape] {
  //    rules.filter { $0.exposesBlockRange }
  //  }

  var rules: [RegexShape] {
    [
      //      .prefix(.heading),
      //      .wrap(.bold),
      //      .wrap(.italic),
      //      .wrap(.boldItalic),
      //      .single(.horizontalRule),
      //      .codeBlock(.codeBlock),
      //      .wrapPair(.link),
      .wrap(.inlineCode)
    ]
  }

  func applyAttributes(
    to text: String,
    attributes: inout AttributedRanges,
    blockRanges: inout [Range<String.Index>]
  ) {
    for rule in self.rules {
      self.thing(rule, to: text, attr: &attributes, blocks: &blockRanges)
    }
  }

  private func thing(
    _ rule: RegexShape,
    to text: String,
    attr: inout AttributedRanges,
    blocks: inout [Range<String.Index>]
  ) {
    switch rule {
      case .wrap(let syntaxRule):
        for match in text.matches(of: syntaxRule.pattern) {
          syntaxRule.apply(
            match: match,
            theme: theme,
            fontSize: fontSize,
            attrs: &attr
          )
          if syntaxRule.exposesBlockRange {
            blocks.append(match.range)
          }
        }
      case .prefix(let syntaxRule):
        for match in text.matches(of: syntaxRule.pattern) {
          syntaxRule.apply(
            match: match,
            theme: theme,
            fontSize: fontSize,
            attrs: &attr
          )
          if syntaxRule.exposesBlockRange {
            blocks.append(match.range)
          }
        }

      case .single(let syntaxRule):
        for match in text.matches(of: syntaxRule.pattern) {
          syntaxRule.apply(
            match: match,
            theme: theme,
            fontSize: fontSize,
            attrs: &attr
          )
          if syntaxRule.exposesBlockRange {
            blocks.append(match.range)
          }
        }

      case .codeBlock(let syntaxRule):
        for match in text.matches(of: syntaxRule.pattern) {
          syntaxRule.apply(
            match: match,
            theme: theme,
            fontSize: fontSize,
            attrs: &attr
          )
          if syntaxRule.exposesBlockRange {
            blocks.append(match.range)
          }
        }

      case .wrapPair(let syntaxRule):
        for match in text.matches(of: syntaxRule.pattern) {
          syntaxRule.apply(
            match: match,
            theme: theme,
            fontSize: fontSize,
            attrs: &attr
          )
          if syntaxRule.exposesBlockRange {
            blocks.append(match.range)
          }
        }
    }
  }
}
