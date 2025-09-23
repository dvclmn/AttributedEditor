//
//  ThemeStyles.swift
//  SwiftDown
//
//  Created by Dave Coleman on 26/2/2025.
//

import NSUI

extension Markdown.Syntax {
  
  public var defaultColor: NSUIColor {
    switch self {
      case .quoteBlock: .label
      case .list: .label
      case .codeBlock: .systemBrown
      case .heading: .label
      case .inlineCode: .systemBrown
      case .italic: .systemIndigo
      case .bold: .systemMint
      case .link: .label
      case .image: .label
      case .body: .label
      case .boldItalic: .systemGray
      case .strikethrough: .systemGray
      case .highlight: .systemOrange
      case .horizontalRule: . systemPurple
    }
  }

  public var defaultStyle: FontStyleType {
    switch self {
      case .quoteBlock: .body
      case .list: .body
      case .codeBlock: .monospaced
      case .heading: .bold
      case .inlineCode: .bold
      case .italic: .monospaced
      case .bold: .bold
      case .link: .bold
      case .image: .bold
      case .body: .body
      case .boldItalic: .italic
      case .strikethrough: .bold
      case .highlight: .body
      case .horizontalRule: .body

    }
  }
  
  public func defaultFont(withSize size: CGFloat) -> FontConfig {
//  public func defaultFont(withSize size: CGFloat = 14) -> FontConfig {
    defaultStyle.preset(withSize: size)
  }

}

