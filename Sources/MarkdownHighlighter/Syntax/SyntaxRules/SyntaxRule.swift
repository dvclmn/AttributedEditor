//
//  Syntax+Preset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import Foundation
import HighlighterCommon

public typealias SyntaxOutput<T> = (
  Regex<T>.Match,
  inout AttributedRanges
) -> Void
typealias SyntaxRule<T> = Markdown.SyntaxRule<T>

extension Markdown {
  public struct SyntaxRule<T> {
    public let syntax: Markdown.Syntax
    public let pattern: Regex<T>
//    let theme: Markdown.Theme
    public let exposesBlockRange: Bool
    
    /// Called when a match is found
    public let apply: SyntaxOutput<T>
    
    public init(
      syntax: Markdown.Syntax,
      pattern: Regex<T>,
//      theme: Markdown.Theme,
      exposesBlockRange: Bool = false,
      apply: @escaping SyntaxOutput<T>
    ) {
      self.syntax = syntax
      self.pattern = pattern
//      self.theme = theme
      self.exposesBlockRange = exposesBlockRange
      self.apply = apply
    }
  }
}

extension Markdown.SyntaxRule {
  func applyAttributes(
    to text: String,
    attributes: inout AttributedRanges
  ) {
    let matches = text.matches(of: pattern)
    for match in matches {
      apply(match, &attributes)
    }
  }
}
