//
//  BackgroundRender.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit

class BackingTextView: NSTextView {
  var blockRanges: [NSRange] = []
  private var hiddenSyntaxRanges: [NSRange] = []  // track what's hidden
  //  internal var selectedRange: NSRange { selectedRanges.first?.rangeValue ?? NSRange(location: 0, length: 0) }

  override func draw(_ dirtyRect: NSRect) {
    /// Draw custom backgrounds before text is rendered
    drawBlockBackgrounds()
    drawCustomReplacements()  // for horizontal rules, etc.
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

extension BackingTextView {
  fileprivate func drawCustomReplacements() {
    guard let layoutManager = layoutManager,
      let textContainer = textContainer,
      let textStorage = textStorage
    else { return }

    // Find all "---" patterns
    let pattern = /---/
    let matches = textStorage.string.matches(of: pattern)

    for match in matches {
      let range = match.range.toNSRange(in: textStorage.string)

      // Hide the hyphens
      layoutManager.setTemporaryAttributes(
        [.foregroundColor: NSColor.clear],
        forCharacterRange: range
      )

      // Draw horizontal rule at that position
      let glyphRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
      let boundingRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

      let ruleRect = NSRect(
        x: boundingRect.origin.x,
        y: boundingRect.midY,
        width: textContainer.size.width - boundingRect.origin.x - 20,
        height: 2
      )

      NSColor.separatorColor.setFill()
      ruleRect.fill()
    }
  }
}
