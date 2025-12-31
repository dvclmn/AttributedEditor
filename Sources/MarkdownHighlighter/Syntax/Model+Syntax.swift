//
//  File.swift
//
//
//  Created by Dave Coleman on 10/8/2024.
//

import CoreTools
import SwiftUI

public enum Markdown {}

/// For RegexShape, go to ``Markdown/Syntax/regexShape``
extension Markdown {
  @CaseDetection
  public enum Syntax: CaseIterable, Identifiable, Equatable, Hashable, Sendable {

    public static var allCases: [Markdown.Syntax] {
      let base: [Markdown.Syntax] = [
        .bold,
        .italic,
        .boldItalic,
        .inlineCode,
        .codeBlock,
        .list,
        .quoteBlock(level: 1),
        .quoteBlock(level: 2),
        .quoteBlock(level: 3),
        .callout,
        .strikethrough,
        .highlight,
        .link,
        .image,
        .horizontalRule,
      ]
      return allHeadings + base

    }

    case heading(level: Int)
    case bold
    case italic
    case boldItalic
    case inlineCode
    case codeBlock
    case list
    case quoteBlock(level: Int)
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

  public static var allHeadings: [Markdown.Syntax] {
    [
      .heading(level: 1),
      .heading(level: 2),
      .heading(level: 3),
      .heading(level: 4),
      .heading(level: 5),
      .heading(level: 6),
    ]
  }

  public var name: String {
    switch self {
      case .heading(let level): "Heading \(level)"
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

      case .quoteBlock(let level): "Quote block \(level)"
      case .link: "Link"
      case .image: "Image"
    //      case .body: "Body"
    }
  }

  public var isCode: Bool {
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

  //  public var headerLevel: Int? {
  //    switch self {
  //      case .heading1: 1
  //      case .heading2: 2
  //      case .heading3: 3
  //      case .heading4: 4
  //      case .heading5: 5
  //      case .heading6: 6
  //      default: nil
  //    }
  //  }
}

extension Markdown.Syntax: CustomStringConvertible {
  public var description: String { name }
}
