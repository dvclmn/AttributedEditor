//
//  Config+Colours.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import ColourKit

extension Editor {
  public struct Colours {
    let body: CodableColour
    let insertionPoint: CodableColour
  }
}

extension Editor.Colours {
  
  /// Falls back to system colour
  func nsColor(
    for keyPath: KeyPath<Self, CodableColour>
  ) -> NSColor {
    return self[keyPath: keyPath].nsColor ?? .labelColor
  }
}
