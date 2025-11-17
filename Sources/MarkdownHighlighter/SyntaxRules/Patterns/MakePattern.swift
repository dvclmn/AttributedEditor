//
//  MakePattern.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import Foundation
import HighlighterCommon

extension SyntaxRule {
  func apply(
    to text: NSString,
    attributes: inout AttributedRanges
  ) {

    let pattern: String
    let regex: NSRegularExpression
    do {
      pattern = try PatternBuilder.buildPattern(for: self)
      regex = try NSRegularExpression(pattern: pattern, options: regexOptions)
    } catch {
      print("Error building regex pattern: \(error)")
      /// You might log the error or fail gracefully
      return
    }

    let matches = regex.matches(
      in: text as String,
      range: NSRange(location: 0, length: text.length)
    )

    for match in matches {
      apply(match, text, &attributes)
    }
  }

}
