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
          .syntax(.syntaxLeadingPrimary),
          .content(),
          .syntax(.syntaxTrailingPrimary),
        ]

      case .prefix:
        [
          .syntax(.prefix),
          .content(),
        ]

      case .single: [.content(.single)]

      case .codeBlock:
        [
          .syntax(.syntaxLeadingPrimary),
          .metadata(.languageHint),
          .content(.code),
          .syntax(.syntaxTrailingPrimary),
        ]

      case .linkOrImage:
        [
          .metadata(.exclamation),  // Optional, Only for Image
          .syntax(.syntaxLeadingPrimary),
          .content(.label),
          .syntax(.syntaxTrailingPrimary),
          .syntax(.syntaxLeadingSecondary),
          .metadata(.url),
          .syntax(.syntaxTrailingSecondary),
        ]

      case .callout:
        [
          .syntax(.prefix),
          .syntax(.syntaxLeadingPrimary),
          .metadata(.exclamation),
          .content(.label),
          .syntax(.syntaxTrailingPrimary),
          .content(.calloutTitle),
          .content(.general),

        ]
    }
  }

}
