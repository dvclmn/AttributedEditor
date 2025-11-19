//
//  Syntax+CompDefs.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

extension Markdown.Syntax {
  public var components: [Markdown.SyntaxComponent] {
    switch self {
      case .body:
        [.body]
      case .heading1, .heading2, .heading3, .heading4, .heading5, .heading6:
        [
          .heading1Content,
          .heading1Syntax,

          .heading2Content,
          .heading2Syntax,

          .heading3Content,
          .heading3Syntax,

          .heading4Content,
          .heading4Syntax,

          .heading5Content,
          .heading5Syntax,

          .heading6Content,
          .heading6Syntax,
        ]
      case .bold:
        [.boldContent, .boldSyntax]
      case .italic:
        [.italicContent, .italicSyntax]
      case .boldItalic:
        [.boldItalicContent, .boldItalicSyntax]
      case .inlineCode:
        [.inlineCodeContent, .inlineCodeSyntax]
      case .codeBlock:
        [
          .codeBlockContent,
          .codeBlockSyntax,
          .codeBlockLanguageHint,
          .codeBlockBG,
        ]
      case .list:
        [.listContent, .listSyntax]
      case .quoteBlock:
        [.quoteBlockContent, .quoteBlockSyntax, .quoteBlockBG]
      case .callout:
        [
          .calloutContent,
          .calloutSyntax,
          .calloutIcon,
          .calloutBG,
        ]
      case .strikethrough:
        [.strikethroughLine, .strikethroughSyntax, .strikethroughContent]
      case .highlight:
        [.highlightBG, .highlightSyntax, .highlightContent]
      case .link:
        [.linkURL, .linkSyntax, .linkTitle]
      case .image:
        [.imageURL, .imageSyntax, .imageAltText]
      case .horizontalRule:
        [.horizontalRule]
    }
  }
}
