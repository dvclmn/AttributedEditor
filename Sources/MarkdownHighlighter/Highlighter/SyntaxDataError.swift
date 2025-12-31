//
//  SyntaxDataError.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

import Foundation

enum SyntaxDataError: Error {
  case noRegexShape
  case noRegexPattern
}

enum RegexShapeError: Error {
  /// Referring to `AnyRegexOutput/extractValues(as:)`
  case failedValueExtraction(RegexShape, Fragment)
  
}
