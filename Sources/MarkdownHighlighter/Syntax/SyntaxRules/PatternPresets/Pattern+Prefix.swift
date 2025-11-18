//
//  Pattern+Prefix.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

//import Foundation
//import HighlighterCommon

//enum PrefixPattern {
//  static func build(prefix: String, captures: CaptureProfile) throws -> String {
//    guard case .single(let name) = captures else {
//      throw RuleValidationError.incompatible(
//        delimiter: .prefix(prefix),
//        captures: captures
//      )
//    }
//    
//    let p = NSRegularExpression.escapedPattern(for: prefix)
//    return "^\(p)(?<\(name)>.+)$"
//  }
//}
