//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon

/// I think we don't need assoc. values here, because would mean I'm
/// attempting to handle type erasure, and `AnyRegexOutput` should
/// be handling this entirely.
///
/// Also, assoc. value would imply it is possible to express some specific
/// *value*, based on the declared type for a case. However there is no
/// value to be passed in; the type *is* the value.
public enum RegexShape: Equatable, Hashable {
  case wrap
  case prefix
  case single
  case codeBlock
  case wrapPair

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

  public typealias Single = (Substring)

  // E.g. # Header, > Quotes
  public typealias Prefix = (
    Substring,
    prefix: Substring,
    content: Substring,
  )

  // Link, image
  // If link, the 'prefix' group will be empty
  // E.g. prefix = "!"
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
  /// Return a range for a given Regex Match and shape part
  /// `text` is the original main text being searched for matches
  func nsRange(
    for match: Regex<AnyRegexOutput>.Match,
    part shapePart: RegexShape.Fragment,
    in text: String,

  ) -> NSRange? {
    switch self {
      case .wrap:
        guard let values = match.output.extractValues(as: Wrap.self) else { return nil }
        return switch shapePart {
          case .content: values.content.nsRange(in: text)
          case .syntaxStart: values.leading.nsRange(in: text)
          case .syntaxEnd: values.trailing.nsRange(in: text)
          default: nil
        }

      case .codeBlock:
        guard let values = match.output.extractValues(as: CodeBlock.self) else {
          return nil
        }
        return switch shapePart {
          case .content: values.content.nsRange(in: text)
          case .syntaxStart: values.start.nsRange(in: text)
          case .syntaxEnd: values.end.nsRange(in: text)
          case .languageHint: values.langHint.nsRange(in: text)
          default: nil
        }

      // TODO: Complete these
      case .prefix, .single, .wrapPair: return nil

    }
  }
}

//  case wrap(Markdown.Pattern<Wrap>)
//  case prefix(Markdown.Pattern<Prefix>)
//  case single(Markdown.Pattern<Single>)
//  case codeBlock(Markdown.Pattern<CodeBlock>)
//  case wrapPair(Markdown.Pattern<WrapPair>)
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
