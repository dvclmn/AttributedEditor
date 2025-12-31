//
//  SyntaxData.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 24/12/2025.
//

import CoreTools
import Foundation

extension MarkdownHighlighter {
  func processMatch(
    _ match: Regex<AnyRegexOutput>.Match,
    for syntax: Markdown.Syntax,
    runs: inout MarkdownRuns,
  ) throws {

    /// No need to initialise anything if provided Syntax has no regex shape
    guard let shape = syntax.regexShape else {
      throw SyntaxError.noRegexShape
    }

    /// Again, no fragments means no need to init
    guard let fragments = syntax.fragments else {
      throw SyntaxError.noFragments
    }

    for fragment in fragments {

      let range = try shape.range(for: match, fragment: fragment)

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

}
