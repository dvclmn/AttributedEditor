//
//  Syntax+CompDefs.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown.Syntax {

  public var components: [Markdown.Component] {
    switch self {
      case .body:
        [.init(.body, kind: .content)]

      case .heading1:
        [
          .init(.heading1, kind: .content),
          .init(.heading1, kind: .syntax),
        ]

      case .heading2:
        [
          .init(.heading2, kind: .content),
          .init(.heading2, kind: .syntax),
        ]

      case .heading3:
        [
          .init(.heading3, kind: .content),
          .init(.heading3, kind: .syntax),
        ]

      case .heading4:
        [
          .init(.heading4, kind: .content),
          .init(.heading4, kind: .syntax),
        ]

      case .heading5:
        [
          .init(.heading5, kind: .content),
          .init(.heading5, kind: .syntax),
        ]

      case .heading6:
        [
          .init(.heading6, kind: .content),
          .init(.heading6, kind: .syntax),
        ]

      case .bold:
        [
          .init(.bold, kind: .content),
          .init(.bold, kind: .syntax),
        ]

      case .italic:
        [
          .init(.italic, kind: .content),
          .init(.italic, kind: .syntax),
        ]

      case .boldItalic:
        [
          .init(.boldItalic, kind: .content),
          .init(.boldItalic, kind: .syntax),
        ]

      case .inlineCode:
        [
          .init(.inlineCode, kind: .content),
          .init(.inlineCode, kind: .syntax),
          .init(.inlineCode, kind: .background),
        ]

      case .codeBlock:
        [
          .init(.codeBlock, kind: .content),
          .init(.codeBlock, kind: .syntax),
          .init(.codeBlock, kind: .languageHint),
          .init(.codeBlock, kind: .background),
        ]

      case .list:
        [
          .init(.list, kind: .content),
          .init(.list, kind: .syntax),
        ]

      case .quoteBlock:
        [
          .init(.quoteBlock, kind: .content),
          .init(.quoteBlock, kind: .syntax),
          .init(.quoteBlock, kind: .background),
        ]

      case .callout:
        [
          .init(.callout, kind: .content),
          .init(.callout, kind: .syntax),
          .init(.callout, kind: .calloutIcon),
          .init(.callout, kind: .background),
        ]

      case .strikethrough:
        [
          .init(.strikethrough, kind: .strikethroughText),
          .init(.strikethrough, kind: .syntax),
          .init(.strikethrough, kind: .strikethroughLine),
        ]

      case .highlight:
        [
          .init(.highlight, kind: .content),
          .init(.highlight, kind: .syntax),
          .init(.highlight, kind: .background),
        ]

      case .link:
        [
          .init(.link, kind: .content),
          .init(.link, kind: .syntax),
          .init(.link, kind: .url),
        ]

      case .image:
        [
          .init(.image, kind: .content),
          .init(.image, kind: .syntax),
          .init(.image, kind: .url),
        ]

      case .horizontalRule:
        [.init(.horizontalRule, kind: .content)]
    }
  }
  //  public var components: [Markdown.SyntaxComponent] {
  //    switch self {
  //      case .body:
  //        [.body]
  //      case .heading1, .heading2, .heading3, .heading4, .heading5, .heading6:
  //        [
  //          .heading1Content,
  //          .heading1Syntax,
  //
  //          .heading2Content,
  //          .heading2Syntax,
  //
  //          .heading3Content,
  //          .heading3Syntax,
  //
  //          .heading4Content,
  //          .heading4Syntax,
  //
  //          .heading5Content,
  //          .heading5Syntax,
  //
  //          .heading6Content,
  //          .heading6Syntax,
  //        ]
  //      case .bold:
  //        [.boldContent, .boldSyntax]
  //      case .italic:
  //        [.italicContent, .italicSyntax]
  //      case .boldItalic:
  //        [.boldItalicContent, .boldItalicSyntax]
  //      case .inlineCode:
  //        [.inlineCodeContent, .inlineCodeSyntax]
  //      case .codeBlock:
  //        [
  //          .codeBlockContent,
  //          .codeBlockSyntax,
  //          .codeBlockLanguageHint,
  //          .codeBlockBG,
  //        ]
  //      case .list:
  //        [.listContent, .listSyntax]
  //      case .quoteBlock:
  //        [.quoteBlockContent, .quoteBlockSyntax, .quoteBlockBG]
  //      case .callout:
  //        [
  //          .calloutContent,
  //          .calloutSyntax,
  //          .calloutIcon,
  //          .calloutBG,
  //        ]
  //      case .strikethrough:
  //        [.strikethroughLine, .strikethroughSyntax, .strikethroughContent]
  //      case .highlight:
  //        [.highlightBG, .highlightSyntax, .highlightContent]
  //      case .link:
  //        [.linkURL, .linkSyntax, .linkTitle]
  //      case .image:
  //        [.imageURL, .imageSyntax, .imageAltText]
  //      case .horizontalRule:
  //        [.horizontalRule]
  //    }
  //  }
}
