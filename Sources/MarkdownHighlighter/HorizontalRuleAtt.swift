//
//  HorizontalRuleAtt.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit

class HorizontalRuleAttachment: NSTextAttachment {
  override func attachmentBounds(
    for textContainer: NSTextContainer?,
    proposedLineFragment lineFrag: NSRect,
    glyphPosition position: CGPoint,
    characterIndex charIndex: Int
  ) -> NSRect {
    let width = lineFrag.width - 20 // some padding
    return NSRect(x: 0, y: -4, width: width, height: 2)
  }
  
  override func image(
    forBounds imageBounds: NSRect,
    textContainer: NSTextContainer?,
    characterIndex charIndex: Int
  ) -> NSImage? {
    let image = NSImage(size: imageBounds.size)
    image.lockFocus()
    NSColor.separatorColor.setFill()
    NSRect(origin: .zero, size: imageBounds.size).fill()
    image.unlockFocus()
    return image
  }
}
