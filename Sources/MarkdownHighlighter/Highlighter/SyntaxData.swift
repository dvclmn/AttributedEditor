//
//  SyntaxData.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 24/12/2025.
//

import CoreTools
import Foundation

struct SyntaxData {
  let syntax: Markdown.Syntax
  let pattern: Regex<AnyRegexOutput>
  let shape: RegexShape
  let fragments: [Fragment]
}

extension SyntaxData {

  // TODO: Expand on docs here
  /// Three basic components needed to style and find ranges for a syntax.
  /// 1. Shape
  /// 2. Regex Pattern
  /// 3. Fragments
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
      syntax: syntax,
      pattern: pattern,
      shape: shape,
      fragments: fragments
    )
  }

  func processMatch(
    _ match: Regex<AnyRegexOutput>.Match,
    for syntax: Markdown.Syntax,
    runs: inout MarkdownRuns,
  ) {

    for fragment in fragments {
      let range = shape.range(for: match, fragment: fragment)
      guard let range else {
        print("No range for fragment: \(fragment)")
        continue
      }

      /// Currently using the range as the sole marker for 'equality' here
      let runAlreadyExists = runs.contains(where: { $0.range == range })
      guard !runAlreadyExists else { continue }

      /// If a run with this range is not already present, add a new one
      let run = SyntaxRun(
        syntax: syntax,
        role: fragment.toStyleRole,
        range: range
      )
      runs.append(run)
    }
  }

  private func range(
    for fragment: Fragment,
    in match: Regex<AnyRegexOutput>.Match
  ) -> Range<String.Index>? {
    shape.range(for: match, fragment: fragment)
  }
}
