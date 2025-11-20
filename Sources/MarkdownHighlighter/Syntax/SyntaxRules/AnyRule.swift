//
//  AnyRule.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import Foundation

public struct AnyRule {
  public let syntax: Markdown.Syntax
  public let exposesBlockRange: Bool
  private let _matches: (String) -> [AnyRuleMatch]

  public init<T>(_ rule: SyntaxRule<T>) {
    syntax = rule.syntax
    exposesBlockRange = rule.exposesBlockRange

    _matches = { text in
      text.matches(of: rule.pattern).compactMap { match in
        guard let typed = AnyRegexOutput(match).extractValues(as: T.self)
        else { return nil }

        return AnyRuleMatch(
          wholeRange: match.range,
          output: typed,
          original: match
        )
      }
    }
  }

  public func matches(in text: String) -> [AnyRuleMatch] {
    _matches(text)
  }
}

public struct AnyRuleMatch {
  public let wholeRange: Range<String.Index>
  public let output: Any
  public let original: Any
}
