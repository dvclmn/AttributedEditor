//
//  FeatureSupport.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 30/12/2025.
//

import AppKit

/// Trying to get compiler checked support coverage
public struct Supported {

  public static let syntax: [Markdown.Syntax] = {
    [
      //      .heading1,
      //      .heading2,
      //      .heading3,
      //      .heading4,
      //      .heading5,
      //      .heading6,

      .bold,
      .italic,
      .boldItalic,

      .inlineCode,
      //      .codeBlock,

      //      .list,
      //      .quoteBlock,
      //      .callout,
      .strikethrough,
      .highlight,
      //      .link,
      //      .image,
      .horizontalRule,
    ]
  }()

  public static let textAttributes: [NSAttributedString.Key] = {
    [
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
  }()
}

//extension Supported {
//  public static let
//}
