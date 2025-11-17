//
//  MakePattern.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import CoreTools
import Foundation
import HighlighterCommon

extension SyntaxRule {
  func applyAttributes(
    to text: String,
    attributes: inout AttributedRanges
  ) {
    let matches = text.matches(of: pattern)
    for match in matches {
      apply(match, text, &attributes)
    }
  }
}


//      DisplayString {
//        Divider()
//        Indented("Match") {
//          Labeled("Element count", value: match.count)
//          Labeled("Element count", value: match.output.toString)
//        }
//      }.print()
