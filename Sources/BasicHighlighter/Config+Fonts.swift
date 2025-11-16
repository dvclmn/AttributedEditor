//
//  Config+Fonts.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import SwiftUI
import Sharing
import HighlighterCommon

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
    let body = NSFont.preferredFont(size: size)
    return switch self {
      case .body: body
      case .code: NSFont.preferredFont(size: size, design: .monospaced)
      case .italic: body.italic()
      case .bold: body.bold()
      case .boldItalic: body.boldItalic()
    }
  }
}
