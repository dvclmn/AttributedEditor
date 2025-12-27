//
//  Theme+Token.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit
import CoreTools

/// I'm trying out using ThemePark's `Style` instead of `StyleToken`
/// I think the below is true:
/// - By default, a 'full' resolved SwiftUI font from the environment
///   is passed in right at the top in the `NSViewRepresentable`
///   (converted to an `NSFont`)
/// - I shouldn't be dealing in NSFont here, should only be describing
///   traits/attributes, things that change factors of what's already
///   there such as weight and design.
public struct StyleToken: Sendable, Hashable {

  var foreground: CodableColour?
  var fontTraits: FontTraits?

  var background: BackgroundStyle?
  var decoration: TextDecoration?

  //  init(
  //    colour: CodableColour,
  //    fontTraits: NSFontDescriptor.SymbolicTraits = [],
  //    hasBackground: Bool = false
  //  ) {
  //    self.colour = colour
  //    self.fontTraits = FontTraits(fontTraits)
  //    self.hasBackground = hasBackground
  //  }
}

extension StyleToken {
  static var `default`: StyleToken { .init() }
  var nsColour: NSColor? { foreground?.nsColor }
}

extension StyleToken {
  enum BackgroundStyle: Hashable, Sendable {
    case none
    case roundedRect(CodableColour, cornerRadius: CGFloat)
    case highlight(CodableColour)
  }

  enum TextDecoration: Hashable, Sendable {
    case underline
    case strikethrough
  }
}
