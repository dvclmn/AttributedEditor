//
//  Config+Fonts.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension TextView.Configuration {

  var minFontSize: CGFloat { 9 }

  public var defaultFont: NSFont {
    NSFont.systemFont(ofSize: theme.fontSize)
  }

  public var codeFontSize: CGFloat {
    max(minFontSize, theme.fontSize * 0.88)
  }

  public var italicFont: NSFont {
    let systemFont = NSFont.systemFont(ofSize: theme.fontSize)
    let fontDescriptor = systemFont.fontDescriptor.withSymbolicTraits(.italic)
    return NSFont(descriptor: fontDescriptor, size: theme.fontSize) ?? systemFont
  }

  public var boldItalicFont: NSFont {
    let systemFont = NSFont.systemFont(ofSize: theme.fontSize)
    let fontDescriptor = systemFont.fontDescriptor.withSymbolicTraits([.bold, .italic])
    return NSFont(descriptor: fontDescriptor, size: theme.fontSize) ?? systemFont
  }

  public var boldFont: NSFont {
    NSFont.boldSystemFont(ofSize: theme.fontSize)
  }

  public var mediumFont: NSFont {
    NSFont.systemFont(ofSize: theme.fontSize, weight: .medium)
  }

  public var codeFont: NSFont {
    NSFont.monospacedSystemFont(ofSize: codeFontSize, weight: .medium)
  }

}
