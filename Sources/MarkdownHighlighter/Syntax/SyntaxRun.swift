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
///
/// A Syntax Run is created for each Fragment in a match
package struct SyntaxRun {
  let syntax: Markdown.Syntax
  let fragment: Fragment
  package let range: Range<String.Index>
}

extension SyntaxRun {
  var role: StyleRole { Fragment.Meta(fragment) }

  /// Helpful for Testing, for quickly extracting string for a range
  /// `let content = runs[1].content(in: text)`
  func content(in source: String) -> String {
    source[range].toString
  }

  func debugPreview(in text: String) -> String {
    let rangeText = range.debugPreview(
      in: text,
      captureName: nil,  // fragment.name
      maxContextLength: 20
    )
    return DisplayString {
      Indented("Syntax Run") {
        Labeled("Syntax", value: syntax.name)
        Labeled("Role", value: role.name)
        Labeled("Fragment", value: fragment.name)
        Labeled("Range", value: range)
        Labeled("Range Text", value: rangeText)
        Divider()
      }
    }.plainText
  }
}

extension Array where Element == SyntaxRun {

  func debugPreview(in source: String) -> String {
    reduce(into: "") { partialResult, run in
      partialResult += ("\n" + run.debugPreview(in: source))
    }
  }

  /// This is very useful in tests
  func contains(_ syntax: Markdown.Syntax) -> Bool {
    contains { $0.syntax == syntax }
  }

  /// Handy for Testing
  func contents(in source: String) -> [String] {
    map { $0.content(in: source) }
  }

  func textContent(for fragment: Fragment, in text: String) -> String? {
    //  package subscript(fragment: Fragment, source text: String) -> String? {
    guard let run = first(where: { $0.fragment == fragment }) else {
      print("No run for found with Fragment '\(fragment)'")
      return nil
    }
    return run.content(in: text)
  }

}
