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
//@MetaEnum
public enum RegexShape {
  case wrap
  case prefix
  case single
  case codeBlock
  case wrapPair
//  case wrap(Wrap)
//  case prefix(Prefix)
//  case single(Single)
//  case codeBlock(CodeBlock)
//  case wrapPair(WrapPair)
//  case wrap(SyntaxRule<Wrap>)
//  case prefix(SyntaxRule<Prefix>)
//  case single(SyntaxRule<Single>)
//  case codeBlock(SyntaxRule<CodeBlock>)
//  case wrapPair(SyntaxRule<WrapPair>)

  public typealias Single = (Substring)

  // E.g. # Header, > Quotes
  public typealias Prefix = (
    Substring,
    prefix: Substring,
    content: Substring,
  )

  // E.g. *Italics*, ==Highlight==
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
  // If link, the 'prefix' group will be empty
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
