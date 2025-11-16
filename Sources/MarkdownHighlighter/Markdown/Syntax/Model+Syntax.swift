//
//  File.swift
//
//
//  Created by Dave Coleman on 10/8/2024.
//

import CoreTools
import SwiftUI

extension Markdown {
  @CaseDetection
  public enum Syntax: String, Identifiable, Equatable, Hashable, Sendable {

    case body
    case heading1
    case heading2
    case heading3
    case heading4
    case heading5
    case heading6
    //    case heading(level: Int)
    case bold
    case italic
    case boldItalic

    case inlineCode
    case codeBlock
    case list
    case quoteBlock

    case link
    case image
    case strikethrough
    case highlight

    case horizontalRule

  }
}

extension Markdown.Syntax {
  nonisolated public var id: String { name }

  public var name: String {

    switch self {
      case .heading1: return "Heading 1"
      case .heading2: return "Heading 2"
      case .heading3: return "Heading 3"
      case .heading4: return "Heading 4"
      case .heading5: return "Heading 5"
      case .heading6: return "Heading 6"
      //      case .heading(let level):
      //        return "Heading \(level)"

      case .bold: return "Bold"
      case .italic: return "Italic"
      case .boldItalic: return "Bold Italic"
      case .strikethrough: return "Strikethrough"
      case .highlight: return "Highlight"
      case .inlineCode: return "Inline code"
      case .list: return "List"
      case .horizontalRule: return "Horizontal rule"
      case .codeBlock: return "Code block"

      case .quoteBlock: return "Quote"
      case .link: return "Link"
      case .image: return "Image"
      case .body: return "Body"

    }

  }

  //  public var type: Markdown.SyntaxKind {
  //    switch self {
  //      case .bold, .italic, .boldItalic, .strikethrough, .highlight, .inlineCode:
  //        return .inline
  //
  //      case .heading1, .heading2, .heading3, .heading4, .heading5, .heading6, .codeBlock, .quoteBlock, .list, .link,
  //        .image, .horizontalRule, .body:
  //        return .block
  //
  //    }
  //  }

  public var isCodeSyntax: Bool {
    switch self {
      case .inlineCode, .codeBlock: true
      default: false
    }
  }
}
//    public var shortcuts: [KBShortcut] {
//      switch self {
//        case .heading(let level):
//          return [
//            KBShortcut(
//              .character(Character("\(level)")),
//              modifiers: [.command]
//            )
//          ]
//
//        case .bold:
//          return [
//            KBShortcut(
//              .character("b"),
//              modifiers: [.command],
//              label: KBShortcut.Label(title: self.name, icon: "bold")
//            )
//          ]
//        case .italic:
//          return [
//            KBShortcut(
//              .character("i"),
//              modifiers: [.command],
//              label: KBShortcut.Label(title: self.name, icon: "italic")
//            )
//          ]
//        case .boldItalic:
//          return [
//            KBShortcut(
//              .character("b"),
//              modifiers: [.command, .shift]
//            )
//          ]
//        case .inlineCode:
//          return [
//            KBShortcut(
//              .character("`"),
//              label: KBShortcut.Label(
//                title: self.name, icon: "chevron.left.forwardslash.chevron.right")
//            )
//          ]
//        case .highlight:
//          return [
//            KBShortcut(
//              .character("h"),
//              modifiers: [.command]
//            )
//          ]
//        case .strikethrough:
//          return [
//            KBShortcut(
//              .character("s"),
//              modifiers: [.command]
//            )
//          ]
//
//        default:
//          return []
//      }
//    }
//
//
//    public static func findMatchingSyntax(for shortcut: KBShortcut) -> Markdown.Syntax? {
//      for syntax in Markdown.Syntax.allCases where syntax.shortcuts.contains(shortcut) {
//        return syntax
//      }
//      return nil
//    }

//}
