//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools
import EditorCore
import HighlighterCommon

public typealias MarkdownRun = SyntaxRun<Markdown.Syntax>
public typealias MarkdownRuns = [MarkdownRun]

public final class MarkdownHighlighter: Highlighter {

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

    //    return syntax.compactMap(\.toSemanticKind)
    [
      .inlineCode,
      .bold,
      .italic,
    ]
  }

  /// Build attributed ranges for applying in the Editor
  public func buildStyles(in text: String) -> MarkdownRuns {

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
