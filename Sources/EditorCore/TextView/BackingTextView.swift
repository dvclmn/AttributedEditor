//
//  BackgroundRender.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit

// MARK: - Custom Text View with Background Rendering

class BackingTextView: NSTextView {
  var blockRanges: [NSRange] = []

  override func draw(_ dirtyRect: NSRect) {
    /// Draw custom backgrounds before text is rendered
    drawBlockBackgrounds()
    super.draw(dirtyRect)
  }

  private func drawBlockBackgrounds() {
    guard let layoutManager = layoutManager,
      let textContainer = textContainer
    else { return }

    /// For each block range, calculate its visual bounds and draw a background
    for range in blockRanges {
      let glyphRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)

      /// Get the bounding rect for this glyph range
      /// This tells us where the text physically appears on screen
      let boundingRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

      /// Add padding around the text
      let paddedRect = boundingRect.insetBy(dx: -5, dy: -4).offsetBy(dx: 0, dy: -3)

      /// Create a rounded rectangle path
      let path = NSBezierPath(roundedRect: paddedRect, xRadius: 6, yRadius: 6)

      /// Fill with a subtle background color
      NSColor.controlBackgroundColor.withAlphaComponent(0.5).setFill()
      path.fill()

      /// Optional: draw a border
      NSColor.separatorColor.setStroke()
      path.lineWidth = 1
      path.stroke()
    }
  }

  func updateBlockRanges(_ ranges: [NSRange]) {
    blockRanges = ranges
    needsDisplay = true
  }
}
