//
//  Config+Fonts.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import HighlighterCommon
import Sharing
import SwiftUI

extension Editor {
  public enum FontStyle {
    case body
    case code
    case italic
    case bold
    case boldItalic
  }
}
extension Editor.FontStyle {
  public func font(size: CGFloat) -> NSFont {
    //    @Shared(.fontSize) var fontSize
    let bodyFont = NSFont.preferredFont(size: size)
    return switch self {
      case .body: bodyFont
      case .code: NSFont.preferredFont(size: size, design: .monospaced)
      case .italic: bodyFont.italic()
      case .bold: bodyFont.bold()
      case .boldItalic: bodyFont.boldItalic()
    }
  }
}
