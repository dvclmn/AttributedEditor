//
//  Theme+Token.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit
import CoreTools

public struct StyleToken: Sendable, Hashable {

  public var foreground: CodableColour?
  public var fontTraits: FontTraits?

  public var background: BackgroundStyle?
  public var decoration: TextDecoration?

  public init(
    colour: CodableColour? = nil,
    font: NSFontDescriptor.SymbolicTraits = [],
    fontScale: CGFloat = 1,
    background: BackgroundStyle? = nil,
    decoration: TextDecoration? = nil
  ) {
    self.foreground = colour
    self.fontTraits = FontTraits(font, sizeScale: fontScale)
    self.background = background
    self.decoration = decoration
  }
}

extension StyleToken {
  static var `default`: StyleToken { .init() }
  var nsColour: NSColor? { foreground?.nsColor }
}

extension StyleToken {
  public enum BackgroundStyle: Hashable, Sendable {
    case none
    case roundedRect(CodableColour, cornerRadius: CGFloat)
    case highlight(CodableColour)
  }
}
