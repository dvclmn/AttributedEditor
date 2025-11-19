//
//  RuleSets.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

//import AppKit
//import HighlighterCommon

/// Ordering Matters
/// Regex rules are attempted in sequence:
/// Block rules first (headings, blockquotes, fenced blocks)
///
/// Inline rules after (bold, italic, code spans, links)
//public enum MarkdownRules {
////  public static func defaultSet(fontSize: CGFloat) -> [SyntaxRule] {
////    [
////      //      .heading(fontSize: fontSize),
////      //      .blockquote(fontSize: fontSize),
////      //      .fencedCodeBlock(fontSize: fontSize),
////
////      //      .italic(fontSize: fontSize),
////      .inlineCode(fontSize: fontSize)
////      //      .link(fontSize: fontSize),
////    ]
////  }
//
//  public static func testSet(
//    fontSize: CGFloat
//  ) -> [SyntaxRule<RegexShape.Wrap>] {
//    [
//      .inlineCode(fontSize: fontSize),
////      .bold(fontSize: fontSize),
////      .italic(fontSize: fontSize),
//    ]
//  }
//}
