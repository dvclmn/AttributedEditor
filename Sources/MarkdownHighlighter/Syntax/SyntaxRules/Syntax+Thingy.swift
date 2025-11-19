//
//  Syntax+Thingy.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import Foundation
import HighlighterCommon

extension Markdown {
  public struct StyleLibrary {
    let theme: Theme
    let fontSize: CGFloat
  }
}

extension Markdown.StyleLibrary {
  
//  func applyAttributes<T>(
//    rule: SyntaxRule<T>,
//    to text: String,
//    attributes: inout AttributedRanges
//  ) {
//    let matches = text.matches(of: rule.pattern)
//    for match in matches {
//      apply(
//        rule: rule,
//        match: match,
//        attrs: &attributes
//      )
//    }
//  }
}

extension SyntaxRule where T == RegexShape.Three {

  func apply(
//    rule: Markdown.SyntaxRule,
    //    syntax: Markdown.Syntax,
    match: Regex<T>.Match,
    attrs: inout AttributedRanges
  ) where T == RegexShape.Three {
    //    { match, attrs in

    self.pattern.apply(
      match: match,
    ) {
      path,
      range in

//      let font = NSFont.system(.bold, size: fontSize)

      switch path {

        case \.leading,
          \.trailing:
          attrs.update(.font, with: NSFont.system(.body, size: fontSize * 0.9, monospaced: true), in: range)
          attrs.update(.foregroundColor, with: ThemeColour.syntaxColour, in: range)

        case \.content:
          attrs.update(.font, with: font, in: range)

        default: return
      }

    }
  }
}

//extension Markdown.Descriptor {
//  public func apply(
//    syntax: Markdown.Syntax,
//    attr: inout AttributedRanges
//  ) {
//
//  }
//}
