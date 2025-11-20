//
//  Theme+Token.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit
import CoreTools

struct TokenStyle: Sendable {
  var colour: CodableColour?
  //  var color: NSColor?
  //  var font: NSFont.FontStyle?
  var font: NSFontDescriptor.SymbolicTraits?
  //  var fontTraits: NSFontDescriptor.SymbolicTraits?
  // Future proofing:
  // var scale: CGFloat?
  // var underlining: Bool?
}

extension TokenStyle {
  var nsColour: NSColor? { colour?.nsColor }
  //  func nsFont(ofSize size: CGFloat) -> NSFont? {
  //    self.font?.system(size: size)
  //  }
  
  func nsFont(_ size: CGFloat) -> NSFont? {
    self.font?.resolvedFont(
      size: size,
      baseFont: NSFont.systemFont(ofSize: size)
    )
  }
}
