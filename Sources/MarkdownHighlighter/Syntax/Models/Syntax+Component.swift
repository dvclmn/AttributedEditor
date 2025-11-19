//
//  Syntax+Component.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

extension Markdown {

  /// Provide defaults where possible, that can be overriden
  /// as needed. To reduce repetitive colour/font definitions
  public enum SyntaxComponent {
    case body
    case heading1Content
    case heading1Syntax

    case heading2Content
    case heading2Syntax

    case heading3Content
    case heading3Syntax

    case heading4Content
    case heading4Syntax

    case heading5Content
    case heading5Syntax

    case heading6Content
    case heading6Syntax

    case boldContent
    case boldSyntax

    case italicContent
    case italicSyntax

    case boldItalicContent
    case boldItalicSyntax

    case inlineCodeContent
    case inlineCodeSyntax
    case inlineCodeBG

    case codeBlockContent
    case codeBlockSyntax
    case codeBlockLanguageHint
    case codeBlockBG

    case listContent
    case listSyntax

    case quoteBlockContent
    case quoteBlockSyntax
    case quoteBlockBG

    case calloutContent
    case calloutSyntax
    case calloutIcon
    case calloutBG

    case strikethroughContent
    case strikethroughSyntax
    case strikethroughLine

    case highlightContent
    case highlightSyntax
    case highlightBG

    case linkTitle
    case linkSyntax
    case linkURL

    case imageTitle
    case imageSyntax
    case imageURL

    case horizontalRule

  }
}
