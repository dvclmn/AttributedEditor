//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import Foundation
import CoreTools

@MetaEnum
public enum RegexShape {
  case wrap(SyntaxRule<Wrap>)
  case prefix(SyntaxRule<Prefix>)
  case single(SyntaxRule<Single>)
  case codeBlock(SyntaxRule<CodeBlock>)
  case wrapPair(SyntaxRule<WrapPair>)


/// What needs a special case, and how does RegexShape
/// relate to `Markdown.Component` and fonts/colours too
///
/// Worth noting: RegexShape is *only* concerned with text
/// content, so that helps reduce some coupling, e.g.
/// `SyntaxPart.background` is irrelevant to regex.
//public enum RegexShape: String {
//  case single
//  case prefix
//  case wrap
//  case codeBlock
////  case linePrefix  // for block quotes
//  case wrapPair

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

//  var regexShape: Any.Type {
//    return switch self {
//      case .body:
//        fatalError("Body does not express a regex Shape.")
//
//      case .heading1,
//        .heading2,
//        .heading3,
//        .heading4,
//        .heading5,
//        .heading6:
//        RegexShape.Prefix.self
//
//      case .bold,
//        .italic,
//        .boldItalic,
//        .inlineCode,
//        .strikethrough,
//        .highlight:
//        RegexShape.Wrap.self
//
//      case .codeBlock:
//        RegexShape.CodeBlock.self
//
//      case .list:
//        fatalError("List not yet supported.")
//
//      case .quoteBlock:
//        RegexShape.Prefix.self
//
//      case .callout:
//        fatalError("Callouts not yet supported.")
//
//      case .link, .image:
//        RegexShape.WrapPair.self
//
//      case .horizontalRule:
//        RegexShape.Single.self
//    }
//  }
//}
