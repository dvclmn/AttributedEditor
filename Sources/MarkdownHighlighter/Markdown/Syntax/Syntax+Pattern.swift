//
//  Syntax+GeneratePattern.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import Foundation

extension SyntaxRule {
  func makePattern() -> String {
    switch (delimiter, captures) {

      case (.fenced(let start, let end), .two(let name1, let name2)):
        return """
          \(NSRegularExpression.escapedPattern(for: start))([A-Za-z0-9_+-]*)\\n([\\s\\S]*?)\(NSRegularExpression.escapedPattern(for: end))
          """

      case (.wrapper(let prefix, let suffix), .single(let name)):
        return """
          \(NSRegularExpression.escapedPattern(for: prefix))
          (?<\(name)>.+?)
          \(NSRegularExpression.escapedPattern(for: suffix))
          """

      case (.prefix(let start), .single(let name)):
        return "^\(NSRegularExpression.escapedPattern(for: start))(?<\(name)>.+)$"

      case (.none, _):
        return ".*"

      default:
        fatalError("Pattern generation not implemented")
    }
  }
}
