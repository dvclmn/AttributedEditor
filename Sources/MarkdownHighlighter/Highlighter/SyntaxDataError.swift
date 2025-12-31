//
//  SyntaxDataError.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

import Foundation

enum SyntaxError: Error {
  case noRegexShape
  case noRegexPattern
  case noFragments
}

enum RegexError: Error {
  /// Referring to `AnyRegexOutput/extractValues(as:)`
  case failedValueExtraction(RegexShape, Fragment)
  case noMatches(text: String, syntax: Markdown.Syntax)
  
}
