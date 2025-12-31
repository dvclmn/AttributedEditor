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
  public let syntax: Markdown.Syntax
//  public let role: StyleRole
  public let fragment: Fragment
  public let range: Range<String.Index>
}

extension SyntaxRun {
  var role: StyleRole { fragment.toStyleRole }
//  var fragments: [Fragment]? { syntax.fragments }
  //  struct Metadata {
  //    let matches: [Regex<AnyRegexOutput>.Match]
  //  }

  func withRangePreview(text: String) -> String {
    DisplayString {
      Labeled("Syntax", value: syntax.name)
      Labeled("Role", value: role.name)
      Labeled("Fragment", value: fragment.name)
      Labeled("Range", value: range)
      Labeled(
        "Range text",
        value: range.withPreview(in: text, contextLength: 10)
      )
    }.plainText
  }
}

extension Array where Element == SyntaxRun {
  func text(_ index: Int, in text: String) -> String {
    var result = ""
    for run in self {
      result += text[safe: run.range]?.toString ?? ""
    }
    return result
    //    for run in self {
    //      result += text[safe: run.range.]?.toString ?? ""
    //    }
    //    return result
  }

}
