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
  let theme: Markdown.Theme
  public let exposesBlockRange: Bool

  /// Called when a match is found
  public let apply: SyntaxOutput<T>

  public init(
    syntax: Markdown.Syntax,
    pattern: Regex<T>,
    theme: Markdown.Theme,
    exposesBlockRange: Bool = false,
    apply: @escaping SyntaxOutput<T>
  ) {
    self.syntax = syntax
    self.pattern = pattern
    self.theme = theme
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
  
  func colour(
    for syntax: Markdown.Syntax,
    fallback: NSColor = .textColor
  ) -> NSColor {
    let colour: NSColor? = switch syntax {
      case .body:
        theme.body.nsColour
      case .heading1:
        <#code#>
      case .heading2:
        <#code#>
      case .heading3:
        <#code#>
      case .heading4:
        <#code#>
      case .heading5:
        <#code#>
      case .heading6:
        <#code#>
      case .bold:
        <#code#>
      case .italic:
        <#code#>
      case .boldItalic:
        <#code#>
      case .inlineCode:
        <#code#>
      case .codeBlock:
        <#code#>
      case .list:
        <#code#>
      case .quoteBlock:
        <#code#>
      case .callout:
        <#code#>
      case .strikethrough:
        <#code#>
      case .highlight:
        <#code#>
      case .link:
        <#code#>
      case .image:
        <#code#>
      case .horizontalRule:
        <#code#>
    }
    return colour ?? fallback
  }
}
