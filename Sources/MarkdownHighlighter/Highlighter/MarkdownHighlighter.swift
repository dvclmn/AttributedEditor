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

  var theme: Markdown.Theme

  public var blockRanges: BlockRanges = []

  var rules: [RegexShape] {
    [
      //      .prefix(.heading),
      //      .wrap(.bold),
      //      .wrap(.italic),
      //      .wrap(.boldItalic),
      //      .single(.horizontalRule),
      //      .codeBlock(.codeBlock),
      //      .wrapPair(.link),
      .wrap(.inlineCode)
    ]
  }

  //  public let editorConfig: Editor.Configuration
  //  public var theme: Markdown.Theme

  //  let styleLibrary: Markdown.StyleLibrary

  public init(
    //    config: Editor.Configuration,
    theme: Markdown.Theme,
  ) {
    //    self.editorConfig = config
    self.theme = theme
    //    self.styleLibrary = Markdown.StyleLibrary(
    //      theme: theme,
    //      fontSize: config.fontSize
    //    )
  }

  public func buildStyles(in text: String) -> AttributedRanges {
    //  public func buildStyles(in text: String) -> MarkdownStyles {

    var attrs: AttributedRanges = []
    //    let rules = styleLibrary.rules
    //    var styles = MarkdownStyles(attributes: [], blocks: [])
    for rule in rules {
      let (newAttr, newBlocks) = build(rule, text: text)
      attrs.append(contentsOf: newAttr)
      self.blockRanges.append(contentsOf: newBlocks)
      //      styles.add(attributes: newAttr)
      //      styles.add(blocks: newBlocks)
    }
    return attrs
    //    return styles

    //    var attributes: AttributedRanges = []
    //    var blocks: [Range<String.Index>] = []

    //    styleLibrary.applyAttributes(
    //      to: text,
    //      attributes: &attributes,
    //      blockRanges: &blocks
    //    )
    //    let styles = MarkdownStyles(attributes: attributes, blocks: blocks)
    //    print("Highlighted styles for this run:\n\n\(styles)")
    //    return styles
  }

}
extension MarkdownHighlighter {
  public func updateTheme(_ theme: Markdown.Theme) {
    self.theme = theme
  }
}
