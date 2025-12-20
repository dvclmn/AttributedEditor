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
  public var blockRanges: NSBlockRanges = []
//  public var blockRanges: BlockRanges = []

  var rules: [RegexShape] {
    [
      //      .prefix(.heading),
      /// 📣 Important: The ordering for styles to work is:
      /// 1: `italic`
      /// 2: `bold`
      /// 3: `boldItalic`
      .wrap(.italic),
      .wrap(.bold),
      //      .wrap(.boldItalic),
      //      .single(.horizontalRule),
      //      .wrapPair(.link),
      .wrap(.inlineCode),
//      .codeBlock(.codeBlock),
    ]
  }

  public init(theme: Markdown.Theme = .default) {
    self.theme = theme
  }

  public func buildStyles(in text: String) -> NSAttributedRanges {

    var attrs: NSAttributedRanges = []

    for rule in rules {
      let (newAttr, newBlocks) = buildStyledRanges(rule, text: text)
      attrs.append(contentsOf: newAttr)
      if isDrawingBlocks {
        self.blockRanges.append(contentsOf: newBlocks)
      }
    }
    
    return attrs
  }

}
extension MarkdownHighlighter {
  public func updateTheme(_ theme: Markdown.Theme) {
    self.theme = theme
  }
}
