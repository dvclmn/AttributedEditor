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
    let fontSize: CGFloat

    public init(
      theme: Theme,
      fontSize: CGFloat
    ) {
      self.theme = theme
      self.fontSize = fontSize
    }
  }
}

extension Markdown.StyleLibrary {

  static var orderedRules: [AnyRule] {
    [
      AnyRule(SyntaxRule.heading()),
      //        AnyRule(SyntaxRule.fencedCodeBlock()),
      AnyRule(SyntaxRule.inlineCode()),
      AnyRule(SyntaxRule.bold()),
      AnyRule(SyntaxRule.italic()),
      AnyRule(SyntaxRule.horizontalRule()),

    ]
  }

  func applyAttributes(
    to text: String,
    attributes: inout AttributedRanges
  ) {
    for rule in Self.orderedRules {
      for match in rule.matches(in: text) {
        apply(
          rule: rule,
          match: match,
          text: text,
          attributes: &attributes
        )
      }
    }
  }

  //  static var wrapRules: [SyntaxRule<RegexShape.Wrap>] {
  //    [
  //      SyntaxRule.bold(),
  //      SyntaxRule.italic(),
  //      SyntaxRule.boldItalic(),
  //    ]
  //  }
  //
  //  static var singleRules: [SyntaxRule<RegexShape.Single>] {
  //    [
  //      SyntaxRule.horizontalRule()
  //    ]
  //  }
  //
  //  func applyAttributes(
  //    to text: String,
  //    attributes: inout AttributedRanges
  //  ) {
  //    for rule in Self.wrapRules {
  //      let matches = text.matches(of: rule.pattern)
  //      for match in matches {
  //        rule.applyWrap(
  //          match: match,
  //          theme: self.theme,
  //          fontSize: fontSize,
  //          attrs: &attributes
  //        )
  //      }
  //    }
  //
  //    for rule in Self.singleRules {
  //      let matches = text.matches(of: rule.pattern)
  //      for match in matches {
  //        rule.applySingle(
  //          match: match,
  //          theme: self.theme,
  //          fontSize: fontSize,
  //          attrs: &attributes
  //        )
  //      }
  //    }
  //  }
}

extension Markdown.StyleLibrary {
  //extension AnyRule {
  func apply(
    rule: AnyRule,
    match: AnyRuleMatch,
    text: String,

    attributes: inout AttributedRanges
  ) {
    switch rule.syntax {
      case .bold:
        guard let typed = match.output as? RegexShape.Wrap else {
          //        guard let typedRule = rule as? SyntaxRule<RegexShape.Wrap> else {
          print("Something happened")
          return
        }

        rule.applyWrap(
          match: match,
          theme: theme,
          fontSize: fontSize,
          attrs: &attributes
        )
      // Your existing applyWrap logic

      case .heading1:
        let typed = match.output as! RegexShape.Prefix
      // applyPrefix logic

      case .inlineCode:
        let typed = match.output as! RegexShape.Wrap
      // etc.

      default: break
    }
  }
}
