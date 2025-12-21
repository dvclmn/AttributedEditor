//
//  BackgroundRender.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import HighlighterCommon

class BackingTextView: NSTextView, @MainActor Highlightable {
  var highlighter: (any Highlighter.Core)? = nil

  override func draw(_ dirtyRect: NSRect) {
    /// Draw custom backgrounds before text is rendered
    drawBlocks()
    drawReplacement()  // for horizontal rules, etc.
    super.draw(dirtyRect)
  }

  func drawBlocks() {
    guard let layoutManager, let textContainer, let highlighter
    else { return }

    /// For each block range, calculate its visual bounds and draw a background
    for range in highlighter.blockRanges {

      let rect = boundingRect(
        for: range,
        lm: layoutManager,
        tc: textContainer
      )
      let path = highlighter.drawBlockPath(in: rect)
      path.fill()
      path.stroke()
    }
  }

  func updateHighlighter(with updated: any Highlighter.Core) {
    //  func updateBlockRanges(_ ranges: [NSRange]) {
    highlighter = updated
    //    blockRanges = ranges
    needsDisplay = true
  }
}

extension BackingTextView {
  func drawReplacement() {
    guard
      let layoutManager = layoutManager,
      let textContainer = textContainer,
      let textStorage = textStorage
    else { return }

    let string = textStorage.string
    let matches = string.matches(of: /---/)

    for match in matches {
      guard let range = match.range.toNSRange(in: string) else {
        print("Couldn't get NSrange")
        return
      }

      // Hide the characters
      layoutManager.setTemporaryAttributes(
        [.foregroundColor: NSColor.clear],
        forCharacterRange: range
      )

      // Convert char → glyph → container rect
      let glyphRange = layoutManager.glyphRange(
        forCharacterRange: range, actualCharacterRange: nil)
      var rect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

      // Translate container coordinates → view coordinates
      let origin = self.textContainerOrigin
      rect = rect.offsetBy(dx: origin.x, dy: origin.y)

      // Use a consistent vertical alignment (avoids collapsed bounding rect)
      let lineHeight = layoutManager.defaultLineHeight(
        for: textStorage.attribute(.font, at: range.location, effectiveRange: nil)
          as? NSFont ?? NSFont.systemFont(ofSize: 12))

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
