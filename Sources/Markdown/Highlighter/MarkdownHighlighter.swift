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

public final class MarkdownHighlighter: Highlighter {

  private let isDrawingBlocks: Bool = false
  public var theme: MarkdownTheme
  
  var themeResolver: ThemeResolver {
    
  }

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
    public func buildStyles(in text: String) -> [HighlightRun] {
  
      var runs = [HighlightRun]()
  
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
