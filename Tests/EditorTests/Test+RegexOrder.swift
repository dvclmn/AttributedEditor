//
//  Test+RegexOrder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 1/1/2026.
//

import CoreTools
import Testing

@testable import MarkdownHighlighter

/// Ensuring correct regex precedence/evaluation order
struct RegexOrderTests {
  let highlighter = MarkdownHighlighter()

  @Test
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  func wrapRegexOrder() async throws {
    
    /// Will test whatever syntaxes the highlighter currently holds
    let syntaxes = highlighter.supported.syntax

    let precedenceRules: [[Markdown.Syntax]] = [
      /// More specific → more general
      [.italic, .bold, .boldItalic],
      
      /// Inline must precede block
      [.inlineCode, .codeBlock],
    ]

    for rule in precedenceRules {

      let indices = rule.compactMap { item in
        syntaxes.firstIndex(of: item)
      }

      /// If fewer than 2 are present, ordering is correct, so move onto the next rule
      guard indices.count >= 2 else { continue }

      #expect(indices == indices.sorted())
      //      assertRelativeOrder(in: syntaxes, requiredOrder: rule)
    }
  }
}
