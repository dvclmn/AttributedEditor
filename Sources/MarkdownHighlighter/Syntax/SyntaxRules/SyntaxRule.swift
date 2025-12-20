//
//  Syntax+Preset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import Foundation
import HighlighterCommon

//public typealias AnyRegex = Regex<AnyRegexOutput>
//public typealias SyntaxRule<T> = Markdown.SyntaxRule<T>

extension Markdown {
  public struct SyntaxRule {
    public let syntax: Markdown.Syntax
    public let pattern: any RegexComponent
    public let shape: RegexShape
//    public let theme: Theme
//    public let font: NSFont

    public init(
      for syntax: Markdown.Syntax,
      pattern: any RegexComponent,
      shape: RegexShape
//      pattern: AnyRegex.RegexOutput,
//      theme: Theme,
//      font: NSFont
    ) {
      self.syntax = syntax
      self.pattern = pattern
      self.shape = shape
//      self.theme = theme
//      self.font = font
    }
  }
}

//extension Markdown.SyntaxRule {
//  func buildRule(
//    for syntax: Markdown.Syntax,
//    pattern: Regex<AnyRegexOutput>.RegexOutput,
//    with font: NSFont,
//  ) -> Self {
//    if let shape = pattern.extractValues(as: RegexShape.Wrap.self) {
////    if let shape = pattern as? RegexShape.Wrap {
////    if let shape = T.self as? RegexShape.Wrap.Type {
//      let bold: Regex<RegexShape.Wrap> = Self<RegexShape.Wrap>.bold
//      return Self.init(
//        for: syntax,
//        pattern: <#T##Regex<T>#>,
//        theme: <#T##Markdown.Theme#>,
//        font: <#T##NSFont#>
//      )
//    }
//  }
//}
