//
//  Syntax+Preset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import Foundation
import HighlighterCommon

//public typealias SyntaxOutput<T> = (
//  Regex<T>.Match,
//  inout AttributedRanges
//) -> Void
public typealias SyntaxRule<T> = Markdown.SyntaxRule<T>

extension Markdown {
  public struct SyntaxRule<T> {
    public let syntax: Markdown.Syntax
    public let pattern: Regex<T>
    public let exposesBlockRange: Bool

    public init(
      syntax: Markdown.Syntax,
      pattern: Regex<T>,
      exposesBlockRange: Bool = false,
    ) {
      self.syntax = syntax
      self.pattern = pattern
      self.exposesBlockRange = exposesBlockRange
    }
  }
}
