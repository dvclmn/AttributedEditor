//
//  Theme+Token.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit
import CoreTools
import Sharing

struct TokenStyle: Sendable {
  var colour: CodableColour?
  var font: NSFontDescriptor.SymbolicTraits?
  var fontScaleFactor: CGFloat?
  // var underlining: Bool?
}

extension TokenStyle {
  var nsColour: NSColor? { colour?.nsColor }

//  var nsFont: NSFont? {
////    @Shared(.fontSize) var fontSize
//    //  func nsFont(_ size: CGFloat) -> NSFont? {
//
//    //        let isMono = Self.isMonospaced(for: syntax, part: part)
//    //    let scaleFactor: CGFloat = isMono ? 0.88 : 1.0
//    //    let adjustedFontSize = max(9, size * scaleFactor)
//    let scaledSize = fontSize * (fontScaleFactor ?? 1)
//    return self.font?.resolvedFont(
//      size: scaledSize,
//      //      baseFont: NSFont.systemFont(ofSize: 0)
//      baseFont: NSFont.systemFont(ofSize: fontSize)
//    )
//  }
}
