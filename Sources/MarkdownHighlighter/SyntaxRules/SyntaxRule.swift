//
//  Syntax+Preset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import Foundation
import HighlighterCommon

public typealias SyntaxOutput = (Regex<AnyRegexOutput>.Match, inout AttributedRanges) -> Void

// TODO: Will need to bring the regex options back, wasn't sure how to do for Swift Regex
public struct SyntaxRule {
//public struct SyntaxRule<T: RegexComponent> {
  public let syntax: Markdown.Syntax
  public let delimiter: DelimiterShape
  public let role: ContentRole
  public let captures: CaptureProfile
//  public let regexOutput: any Rege
//  public let regexOptions: NSRegularExpression.Options
  public let exposesBlockRange: Bool

  /// Called when a match is found
  //  public let apply: (
  //    NSTextCheckingResult,
  //    NSString,
  //    inout AttributedRanges
  //  ) -> Void

  public let apply: SyntaxOutput

  public init(
    syntax: Markdown.Syntax,
    delimiter: DelimiterShape,
    role: ContentRole,
    captures: CaptureProfile,
//    regexComponent: any RegexComponent,
//    regexOptions: NSRegularExpression.Options = [],
    exposesBlockRange: Bool = false,
    apply: @escaping SyntaxOutput
//    apply: @escaping (Regex<T>.Match, inout AttributedRanges) -> Void
  ) {
    self.syntax = syntax
    self.delimiter = delimiter
    self.role = role
    self.captures = captures
//    self.regexOutput = regexComponent
//    self.regexOptions = regexOptions
    self.exposesBlockRange = exposesBlockRange
    self.apply = apply
  }
}

extension SyntaxRule {
  var isBlock: Bool { role == .blockText }
}

//public struct SyntaxRule {
//  let syntax: Markdown.Syntax
//  let delimiter: DelimiterShape
//  let role: ContentRole
//  let captures: CaptureProfile
//  let regexOptions: NSRegularExpression.Options
//  let exposesBlockRange: Bool  // whether this rule marks an area for block background rendering
//
//  /// Called when a match is found; responsible for adding attributed ranges
//  public let apply: (NSTextCheckingResult, NSString, inout AttributedRanges) -> Void
//
//  // Convenience to build an NSRegularExpression once per rule if you like
//}

//extension SyntaxRule {
//  static func fencedCodeBlock() -> SyntaxRule {
//    SyntaxRule(
//      syntax: .codeBlock,
//      delimiter: .fenced(start: "```", end: "```"),
//      role: .blockBody(name: "body"),
//      captures: .two(name1: "lang", name2: "body"),
//      regexOptions: [.anchorsMatchLines],
//      apply: { match, text, attributes in
//        let full = match.range(at: 0)
//        let lang  = match.range(withName: "lang")
//        let body  = match.range(withName: "body")
//
//        attributes[full] = [
//          .foregroundColor: NSColor.secondaryLabelColor,
//          .font: codeFont
//        ]
//
//        if lang.location != NSNotFound {
//          attributes[lang] = [.foregroundColor: NSColor.tertiaryLabelColor]
//        }
//
//        if body.location != NSNotFound {
//          attributes[body] = [.foregroundColor: NSColor.textColor]
//        }
//      }
//    )
//  }
//
//  static func heading(level: Int) -> SyntaxRule {
//    let prefix = String(repeating: "#", count: level) + " "
//    return SyntaxRule(
//      syntax: Markdown.Syntax(rawValue: "heading\(level)")!,
//      delimiter: .prefix(prefix),
//      role: .inlineText,
//      captures: .single(name: "content"),
//      regexOptions: [.anchorsMatchLines],
//      apply: { match, text, attributes in
//        let content = match.range(withName: "content")
//        attributes[match.range] = [
//          .font: NSFont.systemFont(ofSize: 22 - CGFloat(level)*1.5,
//                                   weight: .bold)
//        ]
//      }
//    )
//  }
//}
