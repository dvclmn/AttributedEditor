//
//  File.swift
//
//
//  Created by Dave Coleman on 10/8/2024.
//

import CoreTools
import SwiftUI

/// For RegexShape, go to ``Markdown/Syntax/regexShape``
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
    case bold
    case italic
    case boldItalic
    case inlineCode
    case codeBlock
    case list
    case quoteBlock
    case callout
    case strikethrough
    case highlight
    case link
    case image
    case horizontalRule

    // Colour literal?

  }
}

extension Markdown.Syntax {
  nonisolated public var id: String { name }

  public var name: String {
    switch self {
      case .heading1: "Heading 1"
      case .heading2: "Heading 2"
      case .heading3: "Heading 3"
      case .heading4: "Heading 4"
      case .heading5: "Heading 5"
      case .heading6: "Heading 6"

      case .bold: "Bold"
      case .italic: "Italic"
      case .boldItalic: "Bold Italic"
      case .strikethrough: "Strikethrough"
      case .highlight: "Highlight"
      case .inlineCode: "Inline code"
      case .list: "List"
      case .horizontalRule: "Horizontal rule"
      case .codeBlock: "Code block"
      case .callout: "Callout"

      case .quoteBlock: "Quote"
      case .link: "Link"
      case .image: "Image"
      case .body: "Body"
    }
  }

  public var isCodeSyntax: Bool {
    switch self {
      case .inlineCode, .codeBlock: true
      default: false
    }
  }

  public var drawsBackground: Bool {
    switch self {
      case .codeBlock, .inlineCode, .callout, .quoteBlock: true
      default: false
    }
  }
}
