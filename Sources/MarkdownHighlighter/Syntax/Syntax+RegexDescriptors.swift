//
//  Syntax+Regex.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 31/12/2025.
//

//extension Markdown.Syntax {
//  var descriptor: SyntaxDescriptor? {
//    switch self {
//      case .bold:
//        .wrap(
//          WrapSpec(
//            altA: "*",
//            altB: "_",
//            count: 2
//          )
//        )
//
//      case .italic:
//        .wrap(
//          WrapSpec(
//            altA: "*",
//            altB: "_",
//            count: 1
//          )
//        )
//
//      case .boldItalic:
//        .wrap(
//          WrapSpec(
//            altA: "*",
//            altB: "_",
//            count: 3
//          )
//        )
//      case .strikethrough:
//        .wrap(
//          WrapSpec(
//            altA: "~",
//            count: 2
//          )
//        )
//      case .highlight:
//        .wrap(
//          WrapSpec(
//            altA: "=",
//            count: 2
//          )
//        )
//
//      case .heading(let level):
//        .prefix(
//          PrefixSpec(
//            kind: .heading,
//            level: level
//          )
//        )
//
//      case .quoteBlock(let level):
//        .prefix(
//          PrefixSpec(
//            kind: .quoteBlock,
//            level: level
//          )
//        )
//
//      case .inlineCode,
//        .codeBlock,
//        .list,
//        .callout,
//
//        .link,
//        .image,
//        .horizontalRule:
//        nil
//
//    }
//  }
//}
