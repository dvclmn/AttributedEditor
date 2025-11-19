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
        [.init(syntax: .body, kind: .content)]

      case .heading1:
        [
          .init(syntax: .heading1, kind: .content),
          .init(syntax: .heading1, kind: .syntax),
        ]

      case .heading2:
        [
          .init(syntax: .heading2, kind: .content),
          .init(syntax: .heading2, kind: .syntax),
        ]

      case .heading3:
        [
          .init(syntax: .heading3, kind: .content),
          .init(syntax: .heading3, kind: .syntax),
        ]

      case .heading4:
        [
          .init(syntax: .heading4, kind: .content),
          .init(syntax: .heading4, kind: .syntax),
        ]

      case .heading5:
        [
          .init(syntax: .heading5, kind: .content),
          .init(syntax: .heading5, kind: .syntax),
        ]

      case .heading6:
        [
          .init(syntax: .heading6, kind: .content),
          .init(syntax: .heading6, kind: .syntax),
        ]

      case .bold:
        [
          .init(syntax: .bold, kind: .content),
          .init(syntax: .bold, kind: .syntax),
        ]

      case .italic:
        [
          .init(syntax: .italic, kind: .content),
          .init(syntax: .italic, kind: .syntax),
        ]

      case .boldItalic:
        [
          .init(syntax: .boldItalic, kind: .content),
          .init(syntax: .boldItalic, kind: .syntax),
        ]

      case .inlineCode:
        [
          .init(syntax: .inlineCode, kind: .content),
          .init(syntax: .inlineCode, kind: .syntax),
          .init(syntax: .inlineCode, kind: .background),
        ]

      case .codeBlock:
        [
          .init(syntax: .codeBlock, kind: .content),
          .init(syntax: .codeBlock, kind: .syntax),
          .init(syntax: .codeBlock, kind: .other("languageHint")),
          .init(syntax: .codeBlock, kind: .background),
        ]

      case .list:
        [
          .init(syntax: .list, kind: .content),
          .init(syntax: .list, kind: .syntax),
        ]

      case .quoteBlock:
        [
          .init(syntax: .quoteBlock, kind: .content),
          .init(syntax: .quoteBlock, kind: .syntax),
          .init(syntax: .quoteBlock, kind: .background),
        ]

      case .callout:
        [
          .init(syntax: .callout, kind: .content),
          .init(syntax: .callout, kind: .syntax),
          .init(syntax: .callout, kind: .other("icon")),
          .init(syntax: .callout, kind: .background),
        ]

      case .strikethrough:
        [
          .init(syntax: .strikethrough, kind: .content),
          .init(syntax: .strikethrough, kind: .syntax),
          .init(syntax: .strikethrough, kind: .other("line")),
        ]

      case .highlight:
        [
          .init(syntax: .highlight, kind: .content),
          .init(syntax: .highlight, kind: .syntax),
          .init(syntax: .highlight, kind: .background),
        ]

      case .link:
        [
          .init(syntax: .link, kind: .other("title")),
          .init(syntax: .link, kind: .syntax),
          .init(syntax: .link, kind: .other("url")),
        ]

      case .image:
        [
          .init(syntax: .image, kind: .other("altText")),
          .init(syntax: .image, kind: .syntax),
          .init(syntax: .image, kind: .other("url")),
        ]

      case .horizontalRule:
        [.init(syntax: .horizontalRule, kind: .content)]
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
