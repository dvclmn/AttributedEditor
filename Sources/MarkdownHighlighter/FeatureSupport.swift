//
//  FeatureSupport.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 30/12/2025.
//

import AppKit

/// Trying to get compiler checked support coverage
public struct Supported {

  /// 📣 Important: This ordering matters:
  /// 1: `italic`
  /// 2: `bold`
  /// 3: `boldItalic`
  public let syntax: [Markdown.Syntax]
  public let textAttributes: [NSAttributedString.Key]

  public init(syntax: [Markdown.Syntax], attributes: [NSAttributedString.Key] = []) {
    self.syntax = syntax
    self.textAttributes = attributes
  }
}

extension Supported: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Markdown.Syntax...) {
    self.init(syntax: elements, attributes: [])
  }
}

extension Supported {
  public static var `default`: Supported {
    let syntax: [Markdown.Syntax] = [
//      .heading(level: 1),
//      .heading(level: 2),
//      .heading(level: 3),
//      .heading(level: 4),
//      .heading(level: 5),
//      .heading(level: 6),

//      .italic,
      //  .bold,
      //  .boldItalic,
      //  .inlineCode,
      //  .codeBlock,
//        .list,
      //  .quoteBlock,
      //  .callout,
//      .strikethrough,
//      .highlight,
      .link,
      //      .image,
      //      .horizontalRule,
    ]

    let attributes: [NSAttributedString.Key] = [
      .foregroundColor,
      .fontTraits,
      .font,
      .strikethroughColor,
      .strikethroughStyle,
      //      .superscript, // superscriptRange, subscriptRange
      //      .attachment,
      //      .link,
      //      .cursor,
      //      .toolTip
      //      .textHighlightStyle,
      //      .textHighlightColorScheme,
    ]

    return Supported(
      syntax: syntax,
      attributes: attributes
    )
  }

}
