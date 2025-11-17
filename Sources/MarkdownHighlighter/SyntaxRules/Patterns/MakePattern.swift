//
//  MakePattern.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import Foundation
import HighlighterCommon

extension SyntaxRule {
  func apply(to text: NSString, attributes: inout AttributedRanges) {
//  func apply(_ rule: SyntaxRule, to text: NSString, attributes: inout AttributedRanges) {
    let pattern: String
    do {
      pattern = try PatternBuilder.buildPattern(for: self)
    } catch {
      /// You might log the error or fail gracefully
      return
    }

    guard let regex = try? NSRegularExpression(
      pattern: pattern,
      options: regexOptions
    ) else { return }

    let matches = regex.matches(
      in: text as String,
      range: NSRange(location: 0, length: text.length)
    )

    for match in matches {
      apply(match, text, &attributes)
    }
  }

}
