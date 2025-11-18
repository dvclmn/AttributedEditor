//
//  SyntaxDescriptor.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
//import CoreTools
import HighlighterCommon

public typealias SyntaxOutput<T> = (
  Markdown.SyntaxContext<T>,
  inout AttributedRanges
) -> Void

extension Markdown {
  public struct Descriptor<T> {
    let rule: SyntaxRule<T>
    let theme: Markdown.Theme
    let apply: SyntaxOutput<T>

    public init(
      rule: SyntaxRule<T>,
      theme: Markdown.Theme,
      apply: @escaping SyntaxOutput<T>
    ) {
      self.rule = rule
      self.theme = theme
      self.apply = apply
    }
  }
}

extension Markdown.Descriptor {

//  public init() {

    //  func thing(for syntax: Markdown.Syntax) -> Self? {
    //    guard let rule = syntax.rule else { return nil }
    //    let pattern = rule.pattern
    //
    //    return Markdown.Descriptor(
    //      rule: rule,
    //      theme: <#T##Markdown.Theme#>) { context, attr in
    //        <#code#>
    //      }
    //  }

//  }
  //  func apply(
  //    to text: String,
  //    attr: inout AttributedRanges
  //  ) {
  //    let matches = text.matches(of: pattern)
  //    for match in matches {
  //      apply(match, text, &attributes)
  //    }
  //  }
  //

  var syntax: Markdown.Syntax { rule.syntax }
  var pattern: Regex<T> { rule.pattern }

  func applyAttributes(
    to text: String,
    attributes: inout AttributedRanges
  ) {
    let matches = text.matches(of: rule.pattern)
    for match in matches {
      let context = Markdown.SyntaxContext<T>(
        syntax: syntax,
        match: match,
        text: text
      )
      apply(context, &attributes)
      //      apply(match, text, &attributes)
    }
  }

  func colour(
    //    for syntax: Markdown.Syntax,
    fallback: NSColor = .textColor
  ) -> NSColor {
    let colour: NSColor? =
      switch syntax {
        case .body: theme.body.nsColour
        case .inlineCode: theme.inlineCode.nsColour
        case .codeBlock: theme.blockCode.nsColour
        case .strikethrough: theme.strikeThrough.nsColour
        case .highlight: theme.highlight.nsColour

        default: fallback

      }
    return colour ?? fallback
  }
}
