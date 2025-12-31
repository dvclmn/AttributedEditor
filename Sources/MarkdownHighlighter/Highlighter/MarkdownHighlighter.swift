//
//  MarkdownHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools

//import EditorCore

//public typealias MarkdownRun = SyntaxRun<Markdown.Syntax>

package final class MarkdownHighlighter {
  //  public typealias Syntax = Markdown.Syntax

  //  private let isDrawingBlocks: Bool = false
  public var theme: MarkdownTheme
  public var supported: Supported = .default

  public init(theme: MarkdownTheme = .default) {
    self.theme = theme
  }

  /// 📣 Important: This ordering matters:
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  //  public var declaredSyntax: [Markdown.Syntax] {
  //    let elements = Markdown.Syntax.allCases.filter { $0.pattern != nil }
  //    //    print("Declared syntax list:", elements.map(\.name).joined(separator: ", "))
  //    return elements
  //    //    [
  //    //      .inlineCode,
  //    //      .italic,
  //    //      .bold,
  //    ////      .boldItalic,
  //    //      .highlight,
  //    //      .
  //    //    ]
  //  }

  /// Build attributed ranges for applying in the Editor
  package func buildStyles(in text: String) throws -> MarkdownRuns {

    var runs: MarkdownRuns = []

    for syntax in supported.syntax {

      print("Building styles for \(syntax.name)")
      
      /// Ensure we have a Regex pattern for this syntax
      guard let pattern = syntax.descriptor?.pattern else {
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
