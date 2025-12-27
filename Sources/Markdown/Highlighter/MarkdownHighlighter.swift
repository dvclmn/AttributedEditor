//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon
import EditorCore

public final class MarkdownHighlighter: Highlighter.Core {

  private let isDrawingBlocks: Bool = false
  public var theme: Markdown.Theme

  public init(theme: Markdown.Theme = .default) {
    self.theme = theme
  }
  
  /// 📣 Important: This ordering matters:
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  public var declaredSyntax: [SemanticKind] {
    let syntax: [Markdown.Syntax] = [
      .inlineCode,
      .bold,
      .italic,
    ]
    
    return syntax.compactMap(\.toSemanticKind)
  }

  /// Build attributed ranges for applying in the Editor
//  public func buildStyles(in text: String) -> AttributedRanges {
//
//    var attrs: AttributedRanges = []
//
//    for syntax in activeSyntax {
//      processMatches(for: syntax, in: text, &attrs)
//    }
//
//    return attrs
//  }

}
extension MarkdownHighlighter {
  public func updateTheme(_ theme: Markdown.Theme) {
    self.theme = theme
  }
}
