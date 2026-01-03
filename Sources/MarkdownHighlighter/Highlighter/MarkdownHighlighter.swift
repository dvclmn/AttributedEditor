//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools

package final class MarkdownHighlighter {
  public var supported: Supported = .default

  public init() {}

  /// Build attributed ranges for applying to the text in the Editor
  package func buildStyles(in text: String) throws -> MarkdownRuns {

    var runs: MarkdownRuns = []

    for syntax in supported.syntax {

      print("🪛 Building styles for \(syntax.name)")

      let pattern = syntax.pattern

      guard let pattern else {
        throw SyntaxError.noRegexPattern
      }

      let matches = text.matches(of: pattern)

      /// It's ok if there's no matches, right? There's not always going
      /// to be all instances of all syntaxes in a text
      guard !matches.isEmpty else { continue }

      /// Determine if Image or Link, if needed.
      /// This is currently the only 'edge-case' needing special handling
//      if syntax.isLink {
//
//      }
      
      for match in matches {
        try processMatch(
          match,
          for: syntax,
          in: text,
          runs: &runs
        )
      }
    }

    return runs
  }
}
