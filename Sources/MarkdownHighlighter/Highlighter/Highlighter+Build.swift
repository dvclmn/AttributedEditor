//
//  Syntax+Thingy.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import Foundation
import HighlighterCommon

extension MarkdownHighlighter {
  func build(
    _ rule: RegexShape,
    text: String,
  ) -> (AttributedRanges, BlockRanges) {

    var attrs: AttributedRanges = []
    var blocks: BlockRanges = []

    switch rule {
      case .wrap(let syntaxRule):
        for match in text.matches(of: syntaxRule.pattern) {
          syntaxRule.apply(
            match: match,
            theme: theme,
            attrs: &attrs
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
            attrs: &attrs
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
            attrs: &attrs
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
            attrs: &attrs
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
            attrs: &attrs
          )
          if syntaxRule.exposesBlockRange {
            blocks.append(match.range)
          }
        }
    }  // END switch
    return (attrs, blocks)
  }
}
