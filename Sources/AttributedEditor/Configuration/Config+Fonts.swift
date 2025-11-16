//
//  Config+Fonts.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import SwiftUI
import Sharing

extension TextView.Configuration {
  var minFontSize: CGFloat { 9 }
  
  public var defaultFont: NSFont { .systemFont(ofSize: fontSize) }
  public var codeFontSize: CGFloat { max(minFontSize, fontSize * 0.88) }

  public func font(_ style: TextView.FontStyle) -> NSFont {
    
  }
  
  public var italicFont: NSFont {
    let descriptor = defaultFont.fontDescriptor.withSymbolicTraits(.italic)
    return NSFont(descriptor: descriptor, size: fontSize) ?? defaultFont
  }

  public var boldItalicFont: NSFont {
    let descriptor = defaultFont.fontDescriptor.withSymbolicTraits([.bold, .italic])
//    let descriptor = systemFont.fontDescriptor.withSymbolicTraits([.bold, .italic])
    return NSFont(descriptor: descriptor, size: fontSize) ?? defaultFont
  }

  public var boldFont: NSFont {
    NSFont.boldSystemFont(ofSize: theme.fontSize)
  }

//  public var mediumFont: NSFont {
//    NSFont.systemFont(ofSize: theme.fontSize, weight: .medium)
//  }

  public var codeFont: NSFont {
    NSFont.monospacedSystemFont(ofSize: codeFontSize, weight: .medium)
  }

}

extension TextView {
  public enum FontStyle {
    case body
    case code
    case italic
    case bold
    case boldItalic
  }
}
extension TextView.FontStyle {
  public var font: NSFont {
    @Shared(.fontSize) var fontSize
    let body = NSFont.preferredFont(size: fontSize)
    return switch self {
      case .body: body
      case .code: NSFont.preferredFont(size: fontSize, design: .monospaced)
      case .italic: body.italic()
      case .bold: body.bold()
      case .boldItalic: body.boldItalic()
    }
  }
}
