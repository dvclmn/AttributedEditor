//
//  Validation+Error.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import Foundation

public enum RuleValidationError: Error, CustomStringConvertible {
  case incompatible(delimiter: DelimiterShape, captures: CaptureProfile)
  case missingCaptureNames(expected: Int, got: Int)
  case unsupportedDelimiter(DelimiterShape)

  public var description: String {
    switch self {
      case .incompatible(let d, let c):
        return "Delimiter \(d) is incompatible with capture profile \(c)."
      case .missingCaptureNames(let expected, let got):
        return "Expected \(expected) capture names, got \(got)."
      case .unsupportedDelimiter(let d):
        return "Delimiter shape \(d) is not supported by PatternBuilder."
    }
  }
}
