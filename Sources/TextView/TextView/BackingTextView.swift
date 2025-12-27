//
//  BackgroundRender.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import HighlighterCommon

class BackingTextView: NSTextView, Highlightable {
  var highlighter: (any Highlighter)? = nil
//  var blockRanges: [NSRange] = []

//  init() {
//    let tcs = NSTextContentStorage()
//    let tlm = BackingLayout()
//
//    tcs.addTextLayoutManager(tlm)
//    let tc = NSTextContainer(size: .zero)
//
//    super.init(frame: .zero, textContainer: tc)
//  }

//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }

//  func updateHighlighter(with updated: any Highlighter.Core) {
//    highlighter = updated
//    needsDisplay = true
//  }
}

//  override func draw(_ dirtyRect: NSRect) {
//    /// Draw custom backgrounds before text is rendered
//    drawBlocks()
//    drawReplacement()  // for horizontal rules, etc.
//    super.draw(dirtyRect)
//  }
//
//  func drawBlocks() {
//    guard let highlighter else { return }
//
//    for range in blockRanges {
//      //    for range in highlighter {
//      //    for range in highlighter.blockRanges {
//      // Convert NSRange -> NSTextRange
//      guard let textRange = self.textRange(for: range) else { continue }
//
//      // Calculate Rect using TextKit 2
//      let rect = self.boundingRect(for: textRange)
//
//      guard !rect.isEmpty else { continue }
//
//      let path = highlighter.drawBlockPath(in: rect)
//      path.fill()
//      path.stroke()
//    }
//    //    guard let layoutManager, let textContainer, let highlighter
//    //    else { return }
//    //
//    //    /// For each block range, calculate its visual bounds and draw a background
//    //    for range in highlighter.blockRanges {
//    //
//    //      let rect = boundingRect(
//    //        for: range,
//    //        lm: layoutManager,
//    //        tc: textContainer
//    //      )
//    //      let path = highlighter.drawBlockPath(in: rect)
//    //      path.fill()
//    //      path.stroke()
//    //    }
//  }

//}

extension BackingTextView {

  /// `setRenderingAttributes`: In TextKit 1, `setTemporaryAttributes` was
  /// often safe to call during display. In TextKit 2, `setRenderingAttributes` modifies
  /// the state of the layout manager.
  /// Ought to apply these attributes during a `textDidChange` event or a dedicated layout pass,
  /// rather than inside the draw loop.

  //  func drawReplacement() {
  //    // 1. Guard for TK2 manager instead of TK1
  //    guard let textLayoutManager = self.textLayoutManager,
  //      let textStorage = textLayoutManager.textContentManager as? NSTextContentStorage
  //    else { return }
  //
  //    let string = textStorage.textStorage?.string ?? ""
  //    let matches = string.matches(of: /---/)

  //    for match in matches {

  //      guard let nsRange = match.range,
  //      guard let nsRange = match.range.toNSRange(in: string),
  //            let textRange = self.textRange(for: nsRange)
  //      else { continue }

  //      fatalError("Need to fix this")

  // 2. Hide the characters (TextKit 2 way)
  // Note: Ideally, you should set this outside of drawRect (e.g., in textDidChange)
  // to avoid potential layout invalidation loops, but strictly translating your logic:
  //      textLayoutManager.setRenderingAttributes(
  //        [.foregroundColor: NSColor.clear],
  //        for: textRange
  //      )
  //
  //      // 3. Get the rect
  //      let rect = self.boundingRect(for: textRange)
  //
  //      guard !rect.isEmpty else { continue }
  //
  //      // 4. Calculate Rule Position
  //      // In TK2, the segment rect height usually corresponds to the line height.
  //      // We can simply use the midY of the rect.
  //      let ruleY = rect.midY
  //
  //      // We use the view's bounds width, but respect the text container origin padding
  //      let originX = self.textContainerOrigin.x
  //      let ruleRect = NSRect(
  //        x: originX + 5,
  //        y: ruleY - 1, // Subtract 1 to center the 2pt height perfectly
  //        width: self.bounds.width - (originX + 10),
  //        height: 2
  //      )
  //
  //      NSColor.separatorColor.setFill()
  //      ruleRect.fill()
  //    }
  //  }

  //  func drawReplacement() {
  //    guard
  //      let lm = layoutManager,
  //      let tc = textContainer,
  //      let ts = textStorage
  //    else { return }
  //
  //    let string = ts.string
  //    let matches = string.matches(of: /---/)
  //
  //    for match in matches {
  //      guard let range = match.range.toNSRange(in: string) else {
  //        print("Couldn't get NSrange")
  //        return
  //      }
  //
  //      // Hide the characters
  //      lm.setTemporaryAttributes(
  //        [.foregroundColor: NSColor.clear],
  //        forCharacterRange: range
  //      )
  //
  //      // Convert char → glyph → container rect
  //      let glyphRange = lm.glyphRange(
  //        forCharacterRange: range, actualCharacterRange: nil)
  //      var rect = lm.boundingRect(forGlyphRange: glyphRange, in: tc)
  //
  //      // Translate container coordinates → view coordinates
  //      let origin = self.textContainerOrigin
  //      rect = rect.offsetBy(dx: origin.x, dy: origin.y)
  //
  //      // Use a consistent vertical alignment (avoids collapsed bounding rect)
  //      let lineHeight = lm.defaultLineHeight(
  //        for: ts.attribute(.font, at: range.location, effectiveRange: nil)
  //          as? NSFont ?? NSFont.systemFont(ofSize: 12))
  //
  //      let ruleY = rect.minY + (lineHeight * 0.5)
  //
  //      let ruleRect = NSRect(
  //        x: origin.x + 5,
  //        y: ruleY,
  //        width: bounds.width - (origin.x + 10),
  //        height: 2
  //      )
  //
  //      NSColor.separatorColor.setFill()
  //      ruleRect.fill()
  //    }
  //  }
}
