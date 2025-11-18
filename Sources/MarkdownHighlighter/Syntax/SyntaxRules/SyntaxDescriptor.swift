//
//  SyntaxDescriptor.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
//import CoreTools
import HighlighterCommon

extension Markdown {
  public struct Descriptor<T> {
    let rule: SyntaxRule<T>
    let theme: Markdown.Theme
    let apply: (SyntaxContext<T>) -> Void
  }
}
extension Markdown.Descriptor {
  
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
      apply(context)
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
