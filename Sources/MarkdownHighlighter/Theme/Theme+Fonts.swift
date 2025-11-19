//
//  Theme+Fonts.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools

extension NSFont.FontStyle {
  public func font(
    ofSize size: CGFloat,
    for syntax: Markdown.Syntax,
    kind: Markdown.ComponentKind,
    fallback: Self = .body
  ) -> NSFont {

    let style: NSFont.FontStyle =
      switch (syntax, kind) {

        case (_, .strikeLine): .body
        case (_, .languageHint): .body
        case (_, .url): .body
        case (_, .calloutIcon): .body

        /// Body content
        case (.body, .content): .body
        case (.heading1, .content): .body
        case (.heading2, .content): .body
        case (.heading3, .content): .body
        case (.heading4, .content): .body
        case (.heading5, .content): .body
        case (.heading6, .content): .body
        case (.bold, .content): .body
        case (.italic, .content): .body
        case (.boldItalic, .content): .body
        case (.inlineCode, .content): .body
        case (.codeBlock, .content): .body
        case (.list, .content): .body
        case (.quoteBlock, .content): .body
        case (.callout, .content): .body
        case (.strikethrough, .content): .body
        case (.highlight, .content): .body
        case (.link, .content): .body
        case (.image, .content): .body
        case (.horizontalRule, .content): .body

        /// Syntax characters
        case (.body, .syntaxChar): .body
        case (.heading1, .syntaxChar): .body
        case (.heading2, .syntaxChar): .body
        case (.heading3, .syntaxChar): .body
        case (.heading4, .syntaxChar): .body
        case (.heading5, .syntaxChar): .body
        case (.heading6, .syntaxChar): .body
        case (.bold, .syntaxChar): .body
        case (.italic, .syntaxChar): .body
        case (.boldItalic, .syntaxChar): .body
        case (.inlineCode, .syntaxChar): .body
        case (.codeBlock, .syntaxChar): .body
        case (.list, .syntaxChar): .body
        case (.quoteBlock, .syntaxChar): .body
        case (.callout, .syntaxChar): .body
        case (.strikethrough, .syntaxChar): .body
        case (.highlight, .syntaxChar): .body
        case (.link, .syntaxChar): .body
        case (.image, .syntaxChar): .body
        case (.horizontalRule, .syntaxChar): .body

        /// Backgrounds, if needed
        case (.body, .background): .body
        case (.heading1, .background): .body
        case (.heading2, .background): .body
        case (.heading3, .background): .body
        case (.heading4, .background): .body
        case (.heading5, .background): .body
        case (.heading6, .background): .body
        case (.bold, .background): .body
        case (.italic, .background): .body
        case (.boldItalic, .background): .body
        case (.inlineCode, .background): .body
        case (.codeBlock, .background): .body
        case (.list, .background): .body
        case (.quoteBlock, .background): .body
        case (.callout, .background): .body
        case (.strikethrough, .background): .body
        case (.highlight, .background): .body
        case (.link, .background): .body
        case (.image, .background): .body
        case (.horizontalRule, .background): .body
      }

    return NSFont.system(
      style,
      size: size,
      monospaced: self.isMonospaced(for: syntax, kind: kind)
    )
  }

  func isMonospaced(
    for syntax: Markdown.Syntax,
    kind: Markdown.ComponentKind,
  ) -> Bool {
    
    switch (syntax, kind) {
      case (_, .strikeLine): false
      case (_, .languageHint): false
      case (_, .url): false
      case (_, .calloutIcon): false

      /// Body content
      case (.body, .content): false
      case (.heading1, .content): false
      case (.heading2, .content): false
      case (.heading3, .content): false
      case (.heading4, .content): false
      case (.heading5, .content): false
      case (.heading6, .content): false
      case (.bold, .content): false
      case (.italic, .content): false
      case (.boldItalic, .content): false
      case (.inlineCode, .content): false
      case (.codeBlock, .content): false
      case (.list, .content): false
      case (.quoteBlock, .content): false
      case (.callout, .content): false
      case (.strikethrough, .content): false
      case (.highlight, .content): false
      case (.link, .content): false
      case (.image, .content): false
      case (.horizontalRule, .content): false

      /// Syntax characters
      case (.body, .syntaxChar): false
      case (.heading1, .syntaxChar): false
      case (.heading2, .syntaxChar): false
      case (.heading3, .syntaxChar): false
      case (.heading4, .syntaxChar): false
      case (.heading5, .syntaxChar): false
      case (.heading6, .syntaxChar): false
      case (.bold, .syntaxChar): false
      case (.italic, .syntaxChar): false
      case (.boldItalic, .syntaxChar): false
      case (.inlineCode, .syntaxChar): false
      case (.codeBlock, .syntaxChar): false
      case (.list, .syntaxChar): false
      case (.quoteBlock, .syntaxChar): false
      case (.callout, .syntaxChar): false
      case (.strikethrough, .syntaxChar): false
      case (.highlight, .syntaxChar): false
      case (.link, .syntaxChar): false
      case (.image, .syntaxChar): false
      case (.horizontalRule, .syntaxChar): false

      /// Backgrounds, if needed
      case (.body, .background): false
      case (.heading1, .background): false
      case (.heading2, .background): false
      case (.heading3, .background): false
      case (.heading4, .background): false
      case (.heading5, .background): false
      case (.heading6, .background): false
      case (.bold, .background): false
      case (.italic, .background): false
      case (.boldItalic, .background): false
      case (.inlineCode, .background): false
      case (.codeBlock, .background): false
      case (.list, .background): false
      case (.quoteBlock, .background): false
      case (.callout, .background): false
      case (.strikethrough, .background): false
      case (.highlight, .background): false
      case (.link, .background): false
      case (.image, .background): false
      case (.horizontalRule, .background): false
    }
  }
}

extension Markdown.Component {

  public func font(withSize size: CGFloat) -> NSFont {
    let adjustedFontSize = max(9, size * fontSizeScaleFactor)
    return fontStyle.system(size: adjustedFontSize, monospaced: isMonospaced)
  }

  private var fontStyle: NSFont.FontStyle {
    switch syntax {
      case .bold: .bold
      case .italic: .italic
      case .boldItalic: .boldItalic
      case .heading1, .heading2, .heading3, .heading4, .heading5, .heading6: .bold
      default: .body
    }
  }

  private var fontSizeScaleFactor: CGFloat {
    isMonospaced ? 0.88 : 1.0
  }

  private var isMonospaced: Bool {
    switch kind {
      case .syntaxChar, .languageHint, .url: true

      case .content, .background, .calloutIcon, .strikeLine:
        switch syntax {
          case .inlineCode, .codeBlock: true
          default: false
        }
    }
  }

  /// Let's figure out what each syntax needs,
  /// font description-wise
  ///
  /// It always needs the font size, which is dynamic
  /// So I'd rather focus on the description, and inject
  /// font size later when it's possible
  //  public func font(withSize size: CGFloat) -> NSFont {
  //    let adjustedFontSize = max(9, size * fontSizeScaleFactor)
  //    return fontStyle.system(size: adjustedFontSize, monospaced: isMonospaced)
  //  }
  //
  //  private var fontStyle: NSFont.FontStyle {
  //    if rawLowercased.contains("bold") {
  //      return .bold
  //
  //    } else if rawLowercased.contains("italic") {
  //      return .italic
  //
  //    } else if rawLowercased.contains("bolditalic") {
  //      return .boldItalic
  //
  //    } else {
  //      return .body
  //    }
  //  }
  //
  //  private var fontSizeScaleFactor: CGFloat {
  //    isMonospaced ? 0.88 : 1.0
  //  }
  //
  //  private var isBold: Bool { rawLowercased.contains("bold") }
  //  private var isItalic: Bool { rawLowercased.contains("italic") }
  //
  //  private var rawLowercased: String { rawValue.localizedLowercase }
  //
  //  /// This may become more nuanced later
  //  private var isMonospaced: Bool { isSyntax }
  //
  //  private var isContent: Bool {
  //    rawLowercased.contains("content")
  //  }
  //  private var isSyntax: Bool {
  //    rawLowercased.contains("syntax")
  //  }

  //  private var isHeadingContent: Bool {
  //    rawValue.contains("heading") && rawValue.contains("content")
  //  }
  //  private var isHeadingSyntax: Bool {
  //    rawValue.contains("heading") && rawValue.contains("syntax")
  //  }

}
