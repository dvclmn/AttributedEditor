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
  public let role: StyleRole
  public let range: Range<String.Index>
}

extension SyntaxRun {

  var fragments: [Fragment]? { syntax.fragments }
  struct Metadata {
    let matches: [Regex<AnyRegexOutput>.Match]
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


