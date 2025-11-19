//
//  Theme+Fonts.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//

import AppKit
import CoreTools

extension Markdown.SyntaxComponent {
  //  public struct Fonts {
  //    let syntax:
  //  }

  /// Let's figure out what each syntax needs,
  /// font description-wise
  ///
  /// It always needs the font size, which is dynamic
  /// So I'd rather focus on the description, and inject
  /// font size later when it's possible
  public func font(withSize size: CGFloat) -> NSFont {
    let adjustedFontSize = max(9, size * fontSizeScaleFactor)
    return fontStyle.system(size: adjustedFontSize, monospaced: isMonospaced)
  }

  private var fontStyle: NSFont.FontStyle {
    if rawLowercased.contains("bold") {
      return .bold
      
    } else if rawLowercased.contains("italic") {
      return .italic
      
    } else if rawLowercased.contains("bolditalic") {
      return .boldItalic
      
    } else {
      return .body
    }
  }

  private var fontSizeScaleFactor: CGFloat {
    isMonospaced ? 0.88 : 1.0
  }

  private var isBold: Bool { rawLowercased.contains("bold") }
  private var isItalic: Bool { rawLowercased.contains("italic") }

  private var rawLowercased: String { rawValue.localizedLowercase }

  /// This may become more nuanced later
  private var isMonospaced: Bool { isSyntax }

  private var isContent: Bool {
    rawLowercased.contains("content")
  }
  private var isSyntax: Bool {
    rawLowercased.contains("syntax")
  }

  //  private var isHeadingContent: Bool {
  //    rawValue.contains("heading") && rawValue.contains("content")
  //  }
  //  private var isHeadingSyntax: Bool {
  //    rawValue.contains("heading") && rawValue.contains("syntax")
  //  }

}
