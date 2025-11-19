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
    //    public let apply: SyntaxOutput<T>

    public init(
      syntax: Markdown.Syntax,
      pattern: Regex<T>,
      //      theme: Markdown.Theme,
      exposesBlockRange: Bool = false,
      //      apply: @escaping SyntaxOutput<T>
    ) {
      self.syntax = syntax
      self.pattern = pattern
      //      self.theme = theme
      self.exposesBlockRange = exposesBlockRange
      //      self.apply = apply
    }
  }
}

extension SyntaxRule where T == RegexShape.Wrap {

  func apply(
    //    rule: Markdown.SyntaxRule,
    //    syntax: Markdown.Syntax,
    match: Regex<T>.Match,
    theme: Markdown.Theme,
    attrs: inout AttributedRanges
  ) {

    precondition(syntax.regexShape == .wrap, "Only syntaxes with RegexShape of .wrap are valid here.")

    self.pattern.apply(
      match: match,
    ) {
      path,
      range in

      /// Syntax characters colour/font are mostly the same here, but
      /// there are a few special cases:

      switch path {
        case \.leading:
          attrs.update(.foreground(ThemeColour.syntaxColour.nsColor()), in: range)

        case \.trailing:
          attrs.update(.foreground(ThemeColour.syntaxColour.nsColor()), in: range)

        case \.content:
          //          let colour = theme.colour(for: syntax, kind: .)
          //          attrs.update(.foreground(ThemeColour.syntaxColour.nsColor()), in: range)

        default: return
      }
    }
  }

  private func colour(
    for syntax: Markdown.Syntax,
    theme: Markdown.Theme
  ) -> (syntax: NSColor, content: NSColor) {

    let syntaxColour =
      theme.colour(
        for: self.syntax,
        kind: .syntaxChar,
        fallback: ThemeColour.syntaxColourFallback
      )

    let contentColourIfAvailable: NSColor? = {
      switch syntax {
        case .strikethrough:
          theme.colour(
            for: self.syntax,
            kind: .content,
          )
          
        case .highlight:
          theme.colour(
            for: self.syntax,
            kind: .content,
          )

        default: nil

      }
    }()

    let contentColour = contentColourIfAvailable ?? ThemeColour.contentColourFallback

    return (syntaxColour, contentColour)

  }
}

extension Markdown.SyntaxRule {
  //  func applyAttributes(
  //    to text: String,
  //    attributes: inout AttributedRanges
  //  ) {
  //    let matches = text.matches(of: pattern)
  //    for match in matches {
  //      apply(match, &attributes)
  //    }
  //  }
}
