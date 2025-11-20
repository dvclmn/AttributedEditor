//
//  Syntax+CompDefs.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

//extension Markdown.Syntax {
//
//  public var components: [Markdown.Component] {
//    switch self {
//      case .body:
//        [.init(.body, kind: .content)]
//
//      case .heading1:
//        [
//          .init(.heading1, kind: .content),
//          .init(.heading1, kind: .syntaxChar),
//        ]
//
//      case .heading2:
//        [
//          .init(.heading2, kind: .content),
//          .init(.heading2, kind: .syntaxChar),
//        ]
//
//      case .heading3:
//        [
//          .init(.heading3, kind: .content),
//          .init(.heading3, kind: .syntaxChar),
//        ]
//
//      case .heading4:
//        [
//          .init(.heading4, kind: .content),
//          .init(.heading4, kind: .syntaxChar),
//        ]
//
//      case .heading5:
//        [
//          .init(.heading5, kind: .content),
//          .init(.heading5, kind: .syntaxChar),
//        ]
//
//      case .heading6:
//        [
//          .init(.heading6, kind: .content),
//          .init(.heading6, kind: .syntaxChar),
//        ]
//
//      case .bold:
//        [
//          .init(.bold, kind: .content),
//          .init(.bold, kind: .syntaxChar),
//        ]
//
//      case .italic:
//        [
//          .init(.italic, kind: .content),
//          .init(.italic, kind: .syntaxChar),
//        ]
//
//      case .boldItalic:
//        [
//          .init(.boldItalic, kind: .content),
//          .init(.boldItalic, kind: .syntaxChar),
//        ]
//
//      case .inlineCode:
//        [
//          .init(.inlineCode, kind: .content),
//          .init(.inlineCode, kind: .syntaxChar),
//          .init(.inlineCode, kind: .background),
//        ]
//
//      case .codeBlock:
//        [
//          .init(.codeBlock, kind: .content),
//          .init(.codeBlock, kind: .syntaxChar),
//          .init(.codeBlock, kind: .languageHint),
//          .init(.codeBlock, kind: .background),
//        ]
//
//      case .list:
//        [
//          .init(.list, kind: .content),
//          .init(.list, kind: .syntaxChar),
//        ]
//
//      case .quoteBlock:
//        [
//          .init(.quoteBlock, kind: .content),
//          .init(.quoteBlock, kind: .syntaxChar),
//          .init(.quoteBlock, kind: .background),
//        ]
//
//      case .callout:
//        [
//          .init(.callout, kind: .content),
//          .init(.callout, kind: .syntaxChar),
//          .init(.callout, kind: .calloutIcon),
//          .init(.callout, kind: .background),
//        ]
//
//      case .strikethrough:
//        [
//          .init(.strikethrough, kind: .content),
//          .init(.strikethrough, kind: .syntaxChar),
//          .init(.strikethrough, kind: .strikeLine),
//        ]
//
//      case .highlight:
//        [
//          .init(.highlight, kind: .content),
//          .init(.highlight, kind: .syntaxChar),
//          .init(.highlight, kind: .background),
//        ]
//
//      case .link:
//        [
//          .init(.link, kind: .content),
//          .init(.link, kind: .syntaxChar),
//          .init(.link, kind: .url),
//        ]
//
//      case .image:
//        [
//          .init(.image, kind: .content),
//          .init(.image, kind: .syntaxChar),
//          .init(.image, kind: .url),
//        ]
//
//      case .horizontalRule:
//        [.init(.horizontalRule, kind: .content)]
//    }
//  }
//}
