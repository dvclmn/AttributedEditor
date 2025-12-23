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
struct StyleToken: Sendable, Hashable {
  
  /// Important: Considering taking a cue from ThemePark and looking into
  /// making this non-optional, or at least having a good reason why or why not
  let colour: CodableColour
  let fontTraits: NSFontDescriptor.SymbolicTraits
  
  init(
    colour: CodableColour,
    fontTraits: NSFontDescriptor.SymbolicTraits = []
  ) {
    self.colour = colour
    self.fontTraits = fontTraits
  }
}

extension StyleToken {
  
  func attributeKeys(font: NSFont) -> [AttributeKey?] {
    [
      .init(foreOptional: colour.nsColor),
      .init(fontTraitsOptional: FontTraits(fontTraits, current: font)),
    ]
  }
  
  static var `default`: StyleToken { .init(colour: .primary) }
  var nsColour: NSColor? { colour.nsColor }
}
