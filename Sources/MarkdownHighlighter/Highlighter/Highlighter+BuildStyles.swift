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
      .inlineCode
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
    /// No need to process anything if provided Syntax has no regex shape
    guard let shape = syntax.regexShape else { return }

    /// Ensure we have a Regex pattern for this syntax
    guard let pattern = syntax.pattern else {
      print("No pattern for syntax \(syntax.name)")
      return
    }

    let matches = text.matches(of: pattern)

    guard !matches.isEmpty else {
      print("No matches found for syntax \(syntax.name)")
      return
    }

    for match in matches {
      //      print("Match: \(match.output)")

      let rangeContent = shape.nsRange(for: match, part: .content, in: text)
      let rangeSyntaxStart = shape.nsRange(for: match, part: .syntaxStart, in: text)
      let rangeSyntaxEnd = shape.nsRange(for: match, part: .syntaxEnd, in: text)

      //      switch shape {
      //        case .wrap:
      //
      ////          guard let values = match.output.extractValues(as: Wrap.self) else {
      ////            print("Error getting values \(match.output)")
      ////            return
      ////          }
      //
      //
      //
      ////          matchWithShape(
      ////            syntax: syntax,
      ////            shape: shape,
      ////            match: match,
      ////            theme: theme
      ////          )
      ////
      //
      //        case .prefix: return
      //        case .single: return
      //        case .codeBlock: return
      //        case .wrapPair: return
      //      }

    }
  }

}
