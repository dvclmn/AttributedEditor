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
struct TokenStyle: Sendable {
  var colour: CodableColour?
  var font: NSFontDescriptor.SymbolicTraits?
//  var fontTraits: NSFontDescriptor.SymbolicTraits?
//  var fontWeight: NSFont.Weight?
//  var fontDesign: NSFontDescriptor.SystemDesign?
//  var fontScaleFactor: CGFloat?
}

extension TokenStyle {
  var nsColour: NSColor? { colour?.nsColor }

//  func nsFont(_ size: CGFloat) -> NSFont? {
//
//    let isMono: Bool = self.font?.contains(.monoSpace) ?? false
//    //    let isMono = Self.isMonospaced(for: syntax, part: part)
//
//    let monoFactor: CGFloat? = isMono ? 0.95 : nil
//    //    let adjustedFontSize = max(9, size * scaleFactor)
//    let scaledSize = size * (fontScaleFactor ?? monoFactor ?? 1)
//    return self.font?.resolvedFont(
//      size: scaledSize,
//      baseFont: NSFont.systemFont(ofSize: size)
//    )
//  }
}
