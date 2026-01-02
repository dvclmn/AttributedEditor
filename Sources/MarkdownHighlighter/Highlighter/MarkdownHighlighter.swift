//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools

package final class MarkdownHighlighter {

  public var theme: MarkdownTheme
  public var supported: Supported = .default

  public init(theme: MarkdownTheme = .default) {
    self.theme = theme
  }

  /// Build attributed ranges for applying in the Editor
  package func buildStyles(
    in text: String,
    usingRegexBuilders: Bool = false
  ) throws -> MarkdownRuns {

    var runs: MarkdownRuns = []

    for syntax in supported.syntax {

      print("🪛 Building styles for \(syntax.name)")

      let pattern = syntax.pattern
//      let pattern = usingRegexBuilders ? syntax.descriptor?.pattern : syntax.pattern
      
      guard let pattern else {
        throw SyntaxError.noRegexPattern
      }

      let matches = text.matches(of: pattern)

      /// It's ok if there's no matches, right? There's not always going
      /// to be all instances of all syntaxes in a text
      guard !matches.isEmpty else {
        //        throw RegexError.noMatches
        continue
      }

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
extension MarkdownHighlighter {
  public func updateTheme(_ theme: MarkdownTheme) {
    self.theme = theme
  }
}
