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
  package func buildStyles(in text: String) -> MarkdownRuns {

    var runs: MarkdownRuns = []

    for syntax in supported.syntax {

      guard let data = SyntaxData(syntax: syntax) else {
        print("Couldn't create data for \(syntax.name)")
        assertionFailure("Syntax Data should not be nil.")
        return []
      }

      let matches = text.matches(of: data.pattern)

      guard !matches.isEmpty else {
        print("No matches for \(syntax.name)")
        return []
      }

      for match in matches {
        data.processMatch(
          match,
          for: syntax,
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
