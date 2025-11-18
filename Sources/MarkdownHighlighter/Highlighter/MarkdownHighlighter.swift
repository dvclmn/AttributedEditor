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
  public let theme: Markdown.Theme

  var rules: [SyntaxRule<RegexShape.Three>] {
    let size = editorConfig.fontSize
    return [
      SyntaxRule.inlineCode(fontSize: size, theme: theme)
    ]
    //    MarkdownRules.testSet(fontSize: editorConfig.fontSize)
  }

  public init(
    config: Editor.Configuration,
    theme: Markdown.Theme
  ) {
    self.editorConfig = config
    self.theme = theme
  }

  public func highlight(text: String) -> AttributedRanges {
    var attributes: AttributedRanges = [:]
    //    DisplayString {
    //      "\n\n//////"
    //      //      Labeled("Text to highlight", value: "\n\"\(text.truncate(to: 90))\"\n\n")
    //      Indented("Rules") {
    //        Labeled("Count", value: rules.count)
    //        Labeled("Name", value: rules.map(\.syntax.name))
    //      }
    //
    //    }.print()

    for rule in rules {
      rule.applyAttributes(to: text, attributes: &attributes)
    }
    return attributes
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
