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
  //  var blockRanges: [NSRange]
  //  private var hiddenSyntaxRanges: [NSRange] = []  // track what's hidden
  //  internal var selectedRange: NSRange { selectedRanges.first?.rangeValue ?? NSRange(location: 0, length: 0) }

  //  init(
  //    highlighter: any Highlighter
  //      //    blockRanges: [NSRange] = [],
  //      //    hiddenSyntaxRanges: [NSRange]
  //  ) {
  //    self.highlighter = highlighter
  //    //    self.blockRanges = blockRanges
  //    //    self.hiddenSyntaxRanges = hiddenSyntaxRanges
  //    super.init(frame: .zero)
  //  }
  //
  //  required init?(coder: NSCoder) {
  //    fatalError("init(coder:) has not been implemented")
  //  }

  override func draw(_ dirtyRect: NSRect) {
    /// Draw custom backgrounds before text is rendered
    drawBlocks()
    drawReplacement()  // for horizontal rules, etc.
    super.draw(dirtyRect)
  }

  func drawBlocks() {
    guard let layoutManager, let textContainer, let highlighter
    else { return }

    //    let ranges = highlighter?.blockRanges ?? []

    /// For each block range, calculate its visual bounds and draw a background
    //    for range in ranges. {
    for range in highlighter.blockRanges {
//    for range in highlighter.blockRanges.toNSRanges(in: text) {

      let rect = boundingRect(
        for: range,
        lm: layoutManager,
        tc: textContainer
      )
      let path = highlighter.drawBlockPath(in: rect)
      //      let path = Highlighter.blockPath(in: rect)
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
