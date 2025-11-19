//
//  RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import Foundation

public enum RegexShape {
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
enum RegexShapeKind {
  case single
  case prefix
  case wrap
  case codeBlock
  case linePrefix  // for block quotes
  case wrapPair
}

extension Markdown.Syntax {

  var supportsRegexShape: Bool {
    switch self {
      case .body, .list, .callout: false
      default: true
    }
  }

  var shapeKind: RegexShapeKind {
    switch self {
      case .heading1, .heading2, .heading3, .heading4, .heading5, .heading6:
        .prefix

      case .bold, .italic, .boldItalic, .inlineCode, .strikethrough, .highlight:
        .wrap

      case .codeBlock:
        .codeBlock

      case .quoteBlock:
        .linePrefix

      case .link, .image:
        .wrapPair

      case .horizontalRule:
        .single

      case .body, .list, .callout:
        fatalError("\(self.name) not yet supported.")
    }
  }
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
