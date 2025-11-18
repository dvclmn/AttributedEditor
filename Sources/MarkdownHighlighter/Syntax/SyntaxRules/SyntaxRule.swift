//
//  Syntax+Preset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import Foundation
import HighlighterCommon

public struct SyntaxRule<T> {
  public let syntax: Markdown.Syntax
  public let pattern: Regex<T>
  //  let theme: Markdown.Theme
  public let exposesBlockRange: Bool

  /// Called when a match is found
  //  public let apply: SyntaxOutput<T>

  public init(
    syntax: Markdown.Syntax,
    pattern: Regex<T>,
    //    theme: Markdown.Theme,
    exposesBlockRange: Bool = false,
    //    apply: @escaping SyntaxOutput<T>
  ) {
    self.syntax = syntax
    self.pattern = pattern
    //    self.theme = theme
    self.exposesBlockRange = exposesBlockRange
    //    self.apply = apply
  }
}

extension Markdown.Syntax {
  public var rule: SyntaxRule<RegexShape.Three>? {
    switch self {
      case .inlineCode:
        SyntaxRule(
          syntax: self,
          pattern: /(?<leading>`)(?<content>(?:[^`\n])+?)(?<trailing>`)/,
          exposesBlockRange: true
        )

      default: nil
    }
  }
}
