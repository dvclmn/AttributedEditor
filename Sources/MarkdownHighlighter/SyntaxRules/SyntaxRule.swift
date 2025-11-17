//
//  Syntax+Preset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import Foundation
import HighlighterCommon

public typealias SyntaxOutput = (
  Regex<AnyRegexOutput>.Match,
  String,
  inout AttributedRanges
) -> Void

// TODO: Will need to bring the regex options back, wasn't sure how to do for Swift Regex
public struct SyntaxRule {
  public let syntax: Markdown.Syntax
  public let pattern: Regex<AnyRegexOutput>
  public let exposesBlockRange: Bool

  /// Called when a match is found
  public let apply: SyntaxOutput

  public init(
    syntax: Markdown.Syntax,
    pattern: Regex<AnyRegexOutput>,
    exposesBlockRange: Bool = false,
    apply: @escaping SyntaxOutput
  ) {
    self.syntax = syntax
    self.pattern = pattern
    self.exposesBlockRange = exposesBlockRange
    self.apply = apply
  }
}
