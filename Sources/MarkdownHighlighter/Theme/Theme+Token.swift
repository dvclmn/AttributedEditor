//
//  Theme+Token.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit
import CoreTools

/// I think the below is true:
/// - By default, a 'full' resolved SwiftUI font from the environment
///   is passed in right at the top in the `NSViewRepresentable`
///   (converted to an `NSFont`)
/// - I shouldn't be dealing in NSFont here, should only be describing
///   traits/attributes, things that change factors of what's already
///   there such as weight and design.
struct TokenStyle: Sendable, Hashable {
  let colour: CodableColour?
  let fontTraits: NSFontDescriptor.SymbolicTraits
//  var fontTraits: NSFontDescriptor.SymbolicTraits?
//  var fontWeight: NSFont.Weight?
//  var fontDesign: NSFontDescriptor.SystemDesign?
//  var fontScaleFactor: CGFloat?
  
  init(
    colour: CodableColour?,
    fontTraits: NSFontDescriptor.SymbolicTraits = []
  ) {
    self.colour = colour
    self.fontTraits = fontTraits
  }
}

extension TokenStyle {
  static var blank: TokenStyle { .init(colour: nil) }
  var nsColour: NSColor? { colour?.nsColor }
}
