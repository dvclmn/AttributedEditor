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

  var rules: [SyntaxRule<RegexShape.Wrap>] {
    let size = editorConfig.fontSize
    return [
      SyntaxRule.inlineCode(fontSize: size, theme: theme),
      SyntaxRule.strikethrough(fontSize: size, theme: theme),
      SyntaxRule.highlight(fontSize: size, theme: theme),
      SyntaxRule.italic(fontSize: size, theme: theme),
      SyntaxRule.bold(fontSize: size, theme: theme),
      SyntaxRule.boldItalic(fontSize: size, theme: theme),
    ]
  }

  public init(
    config: Editor.Configuration,
    theme: Markdown.Theme = .default
  ) {
    self.editorConfig = config
    self.theme = theme
  }

  public func highlight(text: String) -> AttributedRanges {
    rules.reduce(into: []) { partialResult, rule in
      rule.applyAttributes(to: text, attributes: &partialResult)
    }
  }

  /// blockRanges computed from same rule set: any rule that marks `exposesBlockRange == true`
  public func blockRanges(text: String) -> [NSRange] {
    var output: [NSRange] = []
    for rule in rules where rule.exposesBlockRange {
      let matches = text.matches(of: rule.pattern)
      let ranges = matches.map { $0.range.toNSRange(in: text) }
      output.append(contentsOf: ranges)
    }

    return output
  }
}
extension MarkdownHighlighter {
  public func updateTheme(_ theme: Markdown.Theme) {
    self.theme = theme
  }
}
