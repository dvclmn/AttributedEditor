//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import CoreTools
import Foundation

/// What needs a special case, and how does RegexShape
/// relate to `Markdown.Component` and fonts/colours too
///
/// Worth noting: RegexShape is *only* concerned with text
/// content, so that helps reduce some coupling, e.g.
/// `SyntaxPart.background` is irrelevant to regex.
@MetaEnum
public enum RegexShape {
  case wrap(SyntaxRule<Wrap>)
  case prefix(SyntaxRule<Prefix>)
  case single(SyntaxRule<Single>)
  case codeBlock(SyntaxRule<CodeBlock>)
  case wrapPair(SyntaxRule<WrapPair>)

  public typealias Single = (Substring)

  // E.g. # Header
  // Also Quotes with > Content
  public typealias Prefix = (
    Substring,
    prefix: Substring,
    content: Substring,
  )

  // E.g. Italic *Content*
  public typealias Wrap = (
    Substring,
    leading: Substring,
    content: Substring,
    trailing: Substring
  )

  public typealias CodeBlock = (
    Substring,
    start: Substring,
    langHint: Substring,
    content: Substring,
    end: Substring
  )

  // Link, image
  // If link, group prefix will be empty
  public typealias WrapPair = (
    Substring,
    prefix: Substring,
    leadingA: Substring,
    title: Substring,
    trailingA: Substring,
    leadingB: Substring,
    url: Substring,
    trailingB: Substring,
  )
}

extension RegexShape {
  var exposesBlockRange: Bool {
    switch self {
      case .wrap(let syntaxRule): syntaxRule.exposesBlockRange
      case .prefix(let syntaxRule): syntaxRule.exposesBlockRange
      case .single(let syntaxRule): syntaxRule.exposesBlockRange
      case .codeBlock(let syntaxRule): syntaxRule.exposesBlockRange
      case .wrapPair(let syntaxRule): syntaxRule.exposesBlockRange
    }
  }
  
}
