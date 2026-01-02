//
//  AttributedRanges.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import CoreTools

package typealias MarkdownRuns = [SyntaxRun]

/// No colours, fonts, background, attrs
/// This is the output of the Highlighter.
package struct SyntaxRun {
  let syntax: Markdown.Syntax
  let fragment: Fragment
  package let range: Range<String.Index>
}

extension SyntaxRun {
  var role: StyleRole { fragment.toStyleRole }

  /// Usage in a test:
  /// `let content = runs[1].content(in: text)`
  func content(in source: String) -> String {
    source[range].toString
  }

  func debugPreview(in text: String) -> String {
    let rangeText = range.debugPreview(
      in: text,
//      captureName: fragment.rawValue,
      maxContextLength: 20
    )
    return DisplayString {
      Indented("Syntax Run") {
        Labeled("Syntax", value: syntax.name)
        Labeled("Role", value: role.name)
        Labeled("Fragment", value: fragment.name)
        Labeled("Range", value: range)
        Labeled("Range Text", value: rangeText)
        "End of Syntax Run"
        Divider()
      }
    }.plainText
  }
}

extension Array where Element == SyntaxRun {

  func debugPreview(in source: String) -> String {
    reduce(into: "") { partialResult, run in
      partialResult += ("\n" + run.debugPreview(in: source))
      //      partialResult += ("\n" + run.content(in: source))
    }
  }
  //  func text(_ index: Int, in text: String) -> String {
  //    self.reduce(into: "") { partialResult, run in
  //      partialResult += text[safe: run.range]?.toString ?? ""
  //    }
  //  }
  func contains(_ syntax: Markdown.Syntax) -> Bool {
    contains { $0.syntax == syntax }
  }

  func contents(in source: String) -> [String] {
    map { $0.content(in: source) }
  }
}
