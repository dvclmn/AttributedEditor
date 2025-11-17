//
//  Pattern+Wrapper.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import Foundation
import HighlighterCommon
//
//enum WrapperPattern {
//  static func build(
//    prefix: String,
//    suffix: String,
//    captures: CaptureProfile
//  ) throws -> String {
//    guard case .single(let name) = captures else {
//      throw RuleValidationError.incompatible(
//        delimiter: .wrapper(prefix: prefix, suffix: suffix),
//        captures: captures
//      )
//    }
//    let p = NSRegularExpression.escapedPattern(for: prefix)
//    let s = NSRegularExpression.escapedPattern(for: suffix)
//
//    return "\(p)(?<\(name)>.+?)\(s)"
//  }
//}
