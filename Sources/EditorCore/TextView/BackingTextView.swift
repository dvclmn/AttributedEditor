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
    guard
      let layoutManager = layoutManager,
      let textContainer = textContainer,
      let textStorage = textStorage
    else { return }
    
    let string = textStorage.string
    let matches = string.matches(of: /---/)
    
    for match in matches {
      let range = match.range.toNSRange(in: string)
      
      // Hide the characters
      layoutManager.setTemporaryAttributes(
        [.foregroundColor: NSColor.clear],
        forCharacterRange: range
      )
      
      // Convert char → glyph → container rect
      let glyphRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
      var rect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
      
      // Translate container coordinates → view coordinates
      let origin = self.textContainerOrigin
      rect = rect.offsetBy(dx: origin.x, dy: origin.y)
      
      // Use a consistent vertical alignment (avoids collapsed bounding rect)
      let lineHeight = layoutManager.defaultLineHeight(for: textStorage.attribute(.font, at: range.location, effectiveRange: nil) as? NSFont ?? NSFont.systemFont(ofSize: 12))
      
      let ruleY = rect.minY + (lineHeight * 0.5)
      
      let ruleRect = NSRect(
        x: origin.x + 5,
        y: ruleY,
        width: bounds.width - (origin.x + 10),
        height: 2
      )
      
      NSColor.separatorColor.setFill()
      ruleRect.fill()
    }
  }

}
