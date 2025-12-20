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
//    public let pattern: Regex<T>
    public let theme: Theme
    public let font: NSFont

    public init(
      for syntax: Markdown.Syntax,
//      pattern: Regex<T>,
      theme: Theme,
      font: NSFont
    ) {
      self.syntax = syntax
//      self.pattern = pattern
      self.theme = theme
      self.font = font
    }
  }
}

extension Markdown.SyntaxRule {
  func buildRule(
    for syntax: Markdown.Syntax,
    pattern: Regex<AnyRegexOutput>.RegexOutput,
    with font: NSFont,
  ) -> Self {
    if let shape = pattern.extractValues(as: RegexShape.Wrap.self) {
//    if let shape = pattern as? RegexShape.Wrap {
//    if let shape = T.self as? RegexShape.Wrap.Type {
      let bold: Regex<RegexShape.Wrap> = Self<RegexShape.Wrap>.bold
      return Self.init(
        for: syntax,
        pattern: <#T##Regex<T>#>,
        theme: <#T##Markdown.Theme#>,
        font: <#T##NSFont#>
      )
    }
  }
}
