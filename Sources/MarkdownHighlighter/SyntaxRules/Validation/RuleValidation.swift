//
//  RuleValidation.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

//import Foundation

//public struct RuleValidator {
//  public static func validate(_ rule: SyntaxRule) throws {
//    let capCount = rule.captures.count
//
//    switch rule.delimiter {
//
//      case .wrapper:
//        guard capCount == 1 else {
//          throw RuleValidationError.incompatible(
//            delimiter: rule.delimiter,
//            captures: rule.captures
//          )
//        }
//
//      case .prefix:
//        guard capCount == 1 else {
//          throw RuleValidationError.incompatible(
//            delimiter: rule.delimiter,
//            captures: rule.captures
//          )
//        }
//
//      case .paired:
//        guard capCount == 2 || capCount == 3 else {
//          throw RuleValidationError.incompatible(
//            delimiter: rule.delimiter,
//            captures: rule.captures
//          )
//        }
//
//      case .fenced:
//        guard capCount == 1 || capCount == 2 else {
//          throw RuleValidationError.incompatible(
//            delimiter: rule.delimiter,
//            captures: rule.captures
//          )
//        }
//
//      case .none:
//        // Accept none or single fallback
//        break
//    }
//  }
//}
