//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

public final class MarkdownHighlighter: Highlighter.Core {

  private let isDrawingBlocks: Bool = false
  public var theme: Markdown.Theme

  public init(theme: Markdown.Theme = .default) {
    self.theme = theme
  }

  /// Build attributed ranges for applying in the Editor
  public func buildStyles(in text: String) -> AttributedRanges {

    var attrs: AttributedRanges = []

    for syntax in activeSyntax {
      processMatches(for: syntax, in: text, &attrs)
    }

    return attrs
  }

}
extension MarkdownHighlighter {
  public func updateTheme(_ theme: Markdown.Theme) {
    self.theme = theme
  }
}
