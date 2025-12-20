//
//  Syntax+Thingy.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import Foundation
import HighlighterCommon

extension MarkdownHighlighter {
  func buildStyledRanges(
    _ shape: RegexShape,
    text: String,
  ) -> (NSAttributedRanges, BlockRanges) {

    var attrs: NSAttributedRanges = []
    var blocks: BlockRanges = []

    switch shape {
      case .wrap(let syntaxRule):
        for match in text.matches(of: syntaxRule.pattern) {
          syntaxRule.apply(
            match: match,
            theme: theme,
            attrs: &attrs
          )
          if syntaxRule.syntax.drawsBackground {
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
          if syntaxRule.syntax.drawsBackground {
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
          if syntaxRule.syntax.drawsBackground {
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
          if syntaxRule.syntax.drawsBackground {
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
          if syntaxRule.syntax.drawsBackground {
            blocks.append(match.range)
          }
        }
    }  // END switch
    return (attrs, blocks)
  }
}
