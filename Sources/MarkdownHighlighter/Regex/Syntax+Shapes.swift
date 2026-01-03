//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import RegexBuilder

extension Markdown.Syntax {

  var regexShape: RegexShape {
    switch self {
      case .heading,
        .quoteBlock, .list:
        .prefix

      case .bold,
        .italic,
        .boldItalic,
        .inlineCode,
        .strikethrough,
        .highlight:
        .wrap

      case .codeBlock:
        .codeBlock

      case .link, .image:
        .linkOrImage

      case .horizontalRule:
        .single

      case .callout: .callout

    }
  }

  var fragments: [Fragment] {
    switch regexShape {
      case .wrap:
        [
          .syntax(.wrapLeadingPrimary),
          .content(),
          .syntax(.wrapTrailingPrimary),
        ]

      case .prefix:
        [
          .syntax(.prefix),
          .content(),
        ]

      case .single: [.content(.single)]

      case .codeBlock:
        [
          .syntax(.wrapLeadingPrimary),
          .metadata(.languageHint),
          .content(.code),
          .syntax(.wrapTrailingPrimary),
        ]

      case .linkOrImage:
        [
          .metadata(.exclamation),  // Optional, Only for Image
          .syntax(.wrapLeadingPrimary),
          .content(.label),
          .syntax(.wrapTrailingPrimary),
          .syntax(.wrapLeadingSecondary),
          .metadata(.url),
          .syntax(.wrapTrailingSecondary),
        ]

      case .callout:
        [
          .syntax(.prefix),
          .syntax(.wrapLeadingPrimary),
          .metadata(.exclamation),
          .content(.label),
          .syntax(.wrapTrailingPrimary),
          .content(.heading),
          .content(.general),

        ]
    }
  }

}
