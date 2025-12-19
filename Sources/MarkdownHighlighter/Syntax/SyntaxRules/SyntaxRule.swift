//
//  Syntax+Preset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import Foundation
import HighlighterCommon

public typealias SyntaxRule<T> = Markdown.SyntaxRule<T>

extension Markdown {
  public struct SyntaxRule<T> {
    public let syntax: Markdown.Syntax
    public let pattern: Regex<T>

    public init(
      for syntax: Markdown.Syntax,
      pattern: Regex<T>,
    ) {
      self.syntax = syntax
      self.pattern = pattern
    }
  }
}
