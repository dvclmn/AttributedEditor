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

//  public var blockRanges: NSBlockRanges = []
  var library: StyleLibrary = .initial

  public init(theme: Markdown.Theme = .default) {
    self.theme = theme
  }

  public func buildStyles(
    in text: String,
    with font: NSFont
  ) -> NSAttributedRanges {

    var attrs: NSAttributedRanges = []

    attrs = library.buildForSyntax(.inlineCode)
//    for rule in library.rules {
//      let thing = library.
//      let (newAttr, newBlocks) = buildStyledRanges(rule, text: text)
//      attrs.append(contentsOf: newAttr)
//      if isDrawingBlocks {
//        self.blockRanges.append(contentsOf: newBlocks)
//      }
//    }

    return attrs
  }

  private var activeSyntax: [Markdown.Syntax] {
    [

      .inlineCode
    ]
  }



}
extension MarkdownHighlighter {
  public func updateTheme(_ theme: Markdown.Theme) {
    self.theme = theme
  }
}
