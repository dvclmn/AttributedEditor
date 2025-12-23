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
      .italic
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

    /// Again, no fragments means no need to process
    guard let fragments = syntax.fragments else { return }

    let matches = text.matches(of: pattern)

    guard !matches.isEmpty else {
      DebugString {
        "No matches for \(syntax.name)"
        Labeled("Fragments", value: fragments.map(\.name))
        Labeled("Attributes", value: attributes)
        Labeled("Text", value: text)
      }
      return
    }

    for match in matches {

    }
  }
  
  private func processMatch(
    match: Regex<AnyRegexOutput>.Match,
    shape: RegexShape,
    fragments: [RegexShape.Fragment],
    attributes: inout AttributedRanges,
  ) {
    
    for fragment in fragments {
      guard
        let range = shape.range(
          for: match,
          fragment: fragment,
        )
      else {
        print("No range for fragment: \(fragment)")
        continue
      }
      let runAlreadyExists = attributes.contains(where: { $0.range == range })
      guard !runAlreadyExists else { continue }
      
      let role = fragment.styleRole
      let textAttrs = theme.textAttributes(for: syntax, role: role)
      let attributedRun = AttributedRun(range: range, attributes: textAttrs)
      
      attributes.append(attributedRun)
    }
  }

}

struct PatternMatch {
//  let syntax: Markdown.Syntax
  let match: Regex<AnyRegexOutput>.Match
  let shape: RegexShape
  let fragments: [RegexShape.Fragment]
}
extension PatternMatch {
  init?() {
    
  }
}
