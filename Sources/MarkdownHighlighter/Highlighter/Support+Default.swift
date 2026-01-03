//
//  Support+Default.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 2/1/2026.
//

import AppKit

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
      .bold,
      //  .boldItalic,
      //  .inlineCode,
      //  .codeBlock,
      //        .list,
      //  .quoteBlock,
      //  .callout,
      .strikethrough,
      .highlight,
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
