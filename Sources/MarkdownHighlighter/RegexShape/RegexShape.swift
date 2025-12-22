//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

/// I think we don't need assoc. values here, because this is attempting
/// to handle type erasure, but `AnyRegexOutput` should be handling
/// this for me anyway.
///
/// `RegexShape` could probably *just* be a namespace, not
/// sure the cases themselves are even needed. Dunno
//@MetaEnum
public enum RegexShape {
  //  case wrap(Markdown.Pattern<Wrap>)
  //  case prefix(Markdown.Pattern<Prefix>)
  //  case single(Markdown.Pattern<Single>)
  //  case codeBlock(Markdown.Pattern<CodeBlock>)
  //  case wrapPair(Markdown.Pattern<WrapPair>)
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
