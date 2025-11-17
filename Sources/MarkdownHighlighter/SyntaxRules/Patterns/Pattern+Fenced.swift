//
//  FencedPattern.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import Foundation
import HighlighterCommon

enum FencedPattern {
  static func build(start: String, end: String, captures: CaptureProfile) throws -> String {
    let s = NSRegularExpression.escapedPattern(for: start)
    let e = NSRegularExpression.escapedPattern(for: end)

    switch captures {
      case .two(let lang, let body):
        return "\(s)(?<\(lang)>[A-Za-z0-9_+-]*)\\n(?<\(body)>[\\s\\S]*?)\(e)"

      case .blockBody(let body):
        return "\(s)\\n(?<\(body)>[\\s\\S]*?)\(e)"

      case .single(let body):  // optional shorthand
        return "\(s)\\n(?<\(body)>[\\s\\S]*?)\(e)"

      default:
        throw RuleValidationError.incompatible(
          delimiter: .fenced(start: start, end: end),
          captures: captures
        )
    }
  }
}
