//
//  Theme+Fonts.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools

extension NSFont {
  //extension Markdown.Theme {
  //extension NSFont.FontStyle {
  /// As with colour, `nil` means a font declaration is not needed
  public static func font(
    ofSize size: CGFloat,
    for syntax: Markdown.Syntax,
    kind: Markdown.ComponentKind,
    fallback: NSFont.FontStyle = .body
  ) -> NSFont? {
    let isMono = Self.isMonospaced(for: syntax, kind: kind)
    let scaleFactor: CGFloat = isMono ? 0.88 : 1.0
    let adjustedFontSize = max(9, size * scaleFactor)
    let style: NSFont.FontStyle =
      switch (syntax, kind) {

        case (_, .strikeLine): .body
        case (_, .languageHint): .body
        case (_, .url): .body
        case (_, .calloutIcon): .body
          
        case (_, .syntaxChar): .body

        /// Body content
        case (.body, .content): .body
        case (.heading1, .content): .body
        case (.heading2, .content): .body
        case (.heading3, .content): .body
        case (.heading4, .content): .body
        case (.heading5, .content): .body
        case (.heading6, .content): .body
        case (.bold, .content): .bold
        case (.italic, .content): .italic
        case (.boldItalic, .content): .boldItalic
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
      size: adjustedFontSize,
      monospaced: isMono
    )
  }

  static func isMonospaced(
    for syntax: Markdown.Syntax,
    kind: Markdown.ComponentKind,
  ) -> Bool {

    switch (syntax, kind) {

      case (_, .syntaxChar): true
      case (_, .languageHint): true
      case (_, .url): true

      case (.inlineCode, _): true
      case (.codeBlock, _): true

      case (_, .strikeLine): false
      case (_, .calloutIcon): false

      case (_, .background): false

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
      case (.list, .content): false
      case (.quoteBlock, .content): false
      case (.callout, .content): false
      case (.strikethrough, .content): false
      case (.highlight, .content): false
      case (.link, .content): false
      case (.image, .content): false
      case (.horizontalRule, .content): false

    }
  }
}

extension Markdown.Component {

//  public func font(withSize size: CGFloat) -> NSFont {
//
//    return fontStyle.system(size: adjustedFontSize, monospaced: isMonospaced)
//  }
//
//  private var fontStyle: NSFont.FontStyle {
//    switch syntax {
//      case .bold: .bold
//      case .italic: .italic
//      case .boldItalic: .boldItalic
//      case .heading1, .heading2, .heading3, .heading4, .heading5, .heading6: .bold
//      default: .body
//    }
//  }
//
//  private var fontSizeScaleFactor: CGFloat {
//
//  }
//
//  private var isMonospaced: Bool {
//    switch kind {
//      case .syntaxChar, .languageHint, .url: true
//
//      case .content, .background, .calloutIcon, .strikeLine:
//        switch syntax {
//          case .inlineCode, .codeBlock: true
//          default: false
//        }
//    }
//  }

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
