//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

public final class MarkdownHighlighter: Highlighter {

  public let editorConfig: Editor.Configuration
  public var theme: Markdown.Theme

  let styleLibrary: Markdown.StyleLibrary

  public init(
    config: Editor.Configuration,
    theme: Markdown.Theme,
  ) {
    self.editorConfig = config
    self.theme = theme
    self.styleLibrary = Markdown.StyleLibrary(theme: theme, fontSize: config.fontSize)
  }

  public func highlight(text: String) -> MarkdownStyles {
    var attributes: AttributedRanges = []
    var blocks: [Range<String.Index>] = []

    styleLibrary.applyAttributes(
      to: text,
      attributes: &attributes,
      blockRanges: &blocks
    )
    let styles = MarkdownStyles(attributes: attributes, blocks: blocks)
    print("Highlighted styles for this run:\n\n\(styles)")
    return styles
  }

}
extension MarkdownHighlighter {
  public func updateTheme(_ theme: Markdown.Theme) {
    self.theme = theme
  }
}
