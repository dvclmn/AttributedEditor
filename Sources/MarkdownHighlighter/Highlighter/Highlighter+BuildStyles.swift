//
//  Highlighter+BuildStyles.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 23/12/2025.
//

import CoreTools
import HighlighterCommon

extension MarkdownHighlighter {
  /// 📣 Important: This ordering matters:
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  var activeSyntax: [Markdown.Syntax] {
    [
      .inlineCode,
      .bold,
      .italic,
    ]
  }

  /// Looks for matches for Markdown syntax in the given text, and populates
  /// `NSAttributedRanges` with attributes based on the current Theme,
  /// and ranges based on the Regex matches.
  /// - Parameters:
  ///   - syntax: The Markdown syntax to process
  ///   - text: The text being searched
  ///   - attrs: An `inout` parameter so attributed ranges can be
  ///     accrued (not overwritten) whilst iterating over syntaxes
  func processMatches(
    for syntax: Markdown.Syntax,
    in text: String,
    _ attributes: inout AttributedRanges
  ) {

    guard let data = SyntaxData(syntax: syntax) else { return }
    let matches = text.matches(of: data.pattern)

    guard !matches.isEmpty else {
      DebugString {
        "No matches for \(syntax.name)"
        Labeled("Fragments", value: data.fragments.map(\.name))
        Labeled("Attributes", value: attributes)
        Labeled("Text", value: text)
      }
      return
    }

    for match in matches {
      data.processMatch(match, theme: theme, attrs: &attributes)
    }
  }

}
