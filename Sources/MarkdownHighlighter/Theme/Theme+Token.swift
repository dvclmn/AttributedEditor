//
//  Theme+Token.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit

struct TokenStyle: Sendable {
  var color: NSColor?
  var fontTraits: NSFontDescriptor.SymbolicTraits?
  // Future proofing:
  // var scale: CGFloat?
  // var underlining: Bool?
}
