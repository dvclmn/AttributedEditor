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
  func wrapShapeOrder() async throws {

    let text = "Some **example** text."

    /// This uses whatever items the highlighter has for it's `supported` property
    let syntaxes = highlighter.supported.syntax

    let precedenceRules: [[Markdown.Syntax]] = [
      [.italic, .bold, .boldItalic],
      [.inlineCode, .codeBlock],
    ]

    for rule in precedenceRules {

      let indices = rule.compactMap { item in
        syntaxes.firstIndex(of: item)
      }

      // If fewer than 2 are present, ordering is vacuously correct
      guard indices.count >= 2 else { return }

      #expect(indices == indices.sorted())
      //      assertRelativeOrder(in: syntaxes, requiredOrder: rule)
    }
  }
}
