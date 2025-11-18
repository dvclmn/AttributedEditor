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
  String,
  inout AttributedRanges
) -> Void

public struct SyntaxRule<T> {
  public let syntax: Markdown.Syntax
  public let pattern: Regex<T>
  public let exposesBlockRange: Bool

  /// Called when a match is found
  public let apply: SyntaxOutput<T>

  public init(
    syntax: Markdown.Syntax,
    pattern: Regex<T>,
    exposesBlockRange: Bool = false,
    apply: @escaping SyntaxOutput<T>
  ) {
    self.syntax = syntax
    self.pattern = pattern
    self.exposesBlockRange = exposesBlockRange
    self.apply = apply
  }
}

extension SyntaxRule {
  func applyAttributes(
    to text: String,
    attributes: inout AttributedRanges
  ) {
    let matches = text.matches(of: pattern)
    for match in matches {
      apply(match, text, &attributes)
    }
  }
}
