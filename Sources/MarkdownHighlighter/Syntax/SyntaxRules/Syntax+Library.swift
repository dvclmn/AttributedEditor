//
//  Syntax+Thingy.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import Foundation
import HighlighterCommon

extension Markdown {
  public struct StyleLibrary: Sendable {
    let theme: Theme
    //    let fontSize: CGFloat

    public init(
      theme: Theme,
      //      fontSize: CGFloat
    ) {
      self.theme = theme
      //      self.fontSize = fontSize
    }
  }
}

extension Markdown.StyleLibrary {

  static var wrapRules: [SyntaxRule<RegexShape.Wrap>] {
    [
      SyntaxRule.bold(),
      SyntaxRule.italic(),
      SyntaxRule.boldItalic(),
    ]
  }

  static var singleRules: [SyntaxRule<RegexShape.Single>] {
    [
      SyntaxRule.horizontalRule()
    ]
  }
  //  static var prefixRules: [SyntaxRule<RegexShape.Wrap>] {
  //    [
  //
  //    ]
  //  }

  func applyAll(
    to text: String,
    attributes: inout AttributedRanges
  ) {
    //    let allRules = Self.wrapRules + Self.singleRules

  }

  private func applyAttributes<T>(
    rules: [SyntaxRule<T>],
    //    rule: SyntaxRule<RegexShape.Wrap>,
    to text: String,
    attributes: inout AttributedRanges
  ) {
    if let shape = T.self as? RegexShape.Single.Type {

      for rule in rules {
        let matches = text.matches(of: rule.pattern)
        for match in matches {

          //          for rule in Self.singleRules {
          rule.apply(
            match: match,
            theme: self.theme,
            attrs: &attributes
          )
          //          }

        }
        //        if let singleRule = rule as? SyntaxRule<RegexShape.Single>,
        //           let singleMatch = match as? Regex<RegexShape.Single>
        //        {

        //        }
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
