//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools
//import EditorCore

//public typealias MarkdownRun = SyntaxRun<Markdown.Syntax>

package  final class MarkdownHighlighter {
  //  public typealias Syntax = Markdown.Syntax

  private let isDrawingBlocks: Bool = false
  public var theme: MarkdownTheme

  public init(theme: MarkdownTheme = .default) {
    self.theme = theme
  }

  /// 📣 Important: This ordering matters:
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  public var declaredSyntax: [Markdown.Syntax] {
    [
      .inlineCode,
      .bold,
      .italic,
    ]
  }

  /// Build attributed ranges for applying in the Editor
  package func buildStyles(in text: String) -> MarkdownRuns {

    var runs: MarkdownRuns = []

    for syntax in declaredSyntax {
      processMatches(for: syntax, in: text, &runs)
    }

    return runs
  }

}
extension MarkdownHighlighter {
  public func updateTheme(_ theme: MarkdownTheme) {
    self.theme = theme
  }
}
