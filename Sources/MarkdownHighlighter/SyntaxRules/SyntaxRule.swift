//
//  Syntax+Preset.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import Foundation
import HighlighterCommon

public struct SyntaxRule {
  public let syntax: Markdown.Syntax
  public let delimiter: DelimiterShape
  public let role: ContentRole
  public let captures: CaptureProfile
  public let regexOptions: NSRegularExpression.Options
  public let exposesBlockRange: Bool

  /// Called when a match is found
  public let apply: (
    NSTextCheckingResult,
    NSString,
    inout AttributedRanges
  ) -> Void

  public init(
    syntax: Markdown.Syntax,
    delimiter: DelimiterShape,
    role: ContentRole,
    captures: CaptureProfile,
    regexOptions: NSRegularExpression.Options = [],
    exposesBlockRange: Bool = false,
    apply: @escaping (NSTextCheckingResult, NSString, inout AttributedRanges) -> Void
  ) {
    self.syntax = syntax
    self.delimiter = delimiter
    self.role = role
    self.captures = captures
    self.regexOptions = regexOptions
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
