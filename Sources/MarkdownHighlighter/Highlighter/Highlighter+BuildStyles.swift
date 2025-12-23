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

struct SyntaxData {
  let syntaxID: Markdown.Syntax.ID
  let pattern: Regex<AnyRegexOutput>
  let shape: RegexShape
  let fragments: [RegexShape.Fragment]
}
extension SyntaxData {
  init?(syntax: Markdown.Syntax) {
    /// No need to process anything if provided Syntax has no regex shape
    guard let shape = syntax.regexShape else { return nil }

    /// Ensure we have a Regex pattern for this syntax
    guard let pattern = syntax.pattern else {
      print("No pattern for syntax \(syntax.name)")
      return nil
    }

    /// Again, no fragments means no need to process
    guard let fragments = syntax.fragments else { return nil }

    self.init(
      syntaxID: syntax.id,
      pattern: pattern,
      shape: shape,
      fragments: fragments
    )
  }

  func processMatch(
    _ match: Regex<AnyRegexOutput>.Match,
    theme: Markdown.Theme,
    attrs attributes: inout AttributedRanges,
  ) {

    for fragment in fragments {
      let range = shape.range(for: match, fragment: fragment)
      guard let range else {
        print("No range for fragment: \(fragment)")
        continue
      }
      let runAlreadyExists = attributes.contains(where: { $0.range == range })
      guard !runAlreadyExists else { continue }

      let role = fragment.styleRole
      let textAttrs = theme.textAttributes(for: syntaxID, role: role)
      let attributedRun = AttributedRun(range: range, attributes: textAttrs)
      attributes.append(attributedRun)
    }
  }

}
