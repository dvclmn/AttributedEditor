//
//  Pattern+Paired.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import Foundation
import HighlighterCommon

enum PairedPattern {
  static func build(prefix: String, mid: String, suffix: String, captures: CaptureProfile) throws -> String {
    let p = NSRegularExpression.escapedPattern(for: prefix)
    let m = NSRegularExpression.escapedPattern(for: mid)
    let s = NSRegularExpression.escapedPattern(for: suffix)
    
    switch captures {
      case .two(let name1, let name2):
        return "\(p)(?<\(name1)>[^\\]]+)\(m)(?<\(name2)>[^\\s)]+)\(s)"
        
      case .three(let name1, let name2, let name3):
        return "\(p)(?<\(name1)>[^\\]]+)\(m)(?<\(name2)>[^\\s)]+)(?:\\s+\"(?<\(name3)>[^\"]+)\")?\(s)"
        
      default:
        throw RuleValidationError.incompatible(
          delimiter: .paired(prefix: prefix, mid: mid, suffix: suffix),
          captures: captures
        )
    }
  }
}
