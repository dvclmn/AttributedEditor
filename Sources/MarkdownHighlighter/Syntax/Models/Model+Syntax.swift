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
      case .heading1: return "Heading 1"
      case .heading2: return "Heading 2"
      case .heading3: return "Heading 3"
      case .heading4: return "Heading 4"
      case .heading5: return "Heading 5"
      case .heading6: return "Heading 6"

      case .bold: return "Bold"
      case .italic: return "Italic"
      case .boldItalic: return "Bold Italic"
      case .strikethrough: return "Strikethrough"
      case .highlight: return "Highlight"
      case .inlineCode: return "Inline code"
      case .list: return "List"
      case .horizontalRule: return "Horizontal rule"
      case .codeBlock: return "Code block"
      case .callout: return "Callout"

      case .quoteBlock: return "Quote"
      case .link: return "Link"
      case .image: return "Image"
      case .body: return "Body"

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
