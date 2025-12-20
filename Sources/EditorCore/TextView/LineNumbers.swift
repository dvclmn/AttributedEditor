//
//  LineNumbers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools

class LineNumberRulerView: NSRulerView {
  /// This stores a reference to the text view we're displaying line numbers for
  weak var textView: NSTextView?

  /// Visual properties for the ruler
  private let backgroundColor = NSColor.clear
  private let textColor = NSColor.tertiaryLabelColor
  private let numberSize: CGFloat = 11.5

  private var font: NSFont {
    let font = NSFont.monospacedDigitSystemFont(ofSize: numberSize, weight: .regular)
    let desc = font.fontDescriptor.withSymbolicTraits(.traitCondensed)
    return NSFont(descriptor: desc, size: numberSize) ?? font
  }

  private let padding: CGFloat = 5

  init(textView: NSTextView) {
    super.init(scrollView: textView.enclosingScrollView, orientation: .verticalRuler)
    self.textView = textView
    self.clientView = textView

    /// Width of the line number gutter
    self.ruleThickness = 36
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func drawHashMarksAndLabels(in rect: NSRect) {
    guard let textView = textView,
      let layoutManager = textView.layoutManager,
      let textContainer = textView.textContainer
    else { return }

    /// Fill the background
    backgroundColor.setFill()
    rect.fill()

    /// Draw a separator line on the right edge
    NSColor.separatorColor.setStroke()
    let linePath = NSBezierPath()
    linePath.move(to: NSPoint(x: bounds.maxX - 0.5, y: bounds.minY))
    linePath.line(to: NSPoint(x: bounds.maxX - 0.5, y: bounds.maxY))
    linePath.lineWidth = 1
    linePath.stroke()

    /// Calculate which lines are visible in the current scroll position
    let visibleRect = textView.visibleRect
    let visibleGlyphRange = layoutManager.glyphRange(
      forBoundingRect: visibleRect, in: textContainer)
    let visibleCharRange = layoutManager.characterRange(
      forGlyphRange: visibleGlyphRange, actualGlyphRange: nil)

    let text = textView.string as NSString
    var lineNumber = 1
    var index = 0

    /// Walk through the text and draw line numbers for visible lines
    while index < text.length {
      /// Find the range of the current line
      let lineRange = text.lineRange(for: NSRange(location: index, length: 0))

      /// Check if this line intersects with the visible range
      if NSIntersectionRange(lineRange, visibleCharRange).length > 0 {
        /// Get the glyph range for this line
        let glyphRange = layoutManager.glyphRange(
          forCharacterRange: lineRange, actualCharacterRange: nil)

        /// Calculate where this line appears vertically
        let lineRect = layoutManager.boundingRect(
          forGlyphRange: glyphRange, in: textContainer)

        /// Convert from text view coordinates to ruler coordinates
        let lineY = lineRect.minY - visibleRect.minY

        /// Draw the line number
        let lineNumberString = "\(lineNumber)" as NSString
        let attributes: TextAttributes = [
          .font: font,
          .foregroundColor: textColor,
        ]

        let stringSize = lineNumberString.size(withAttributes: attributes)
        let drawPoint = NSPoint(
          x: bounds.width - stringSize.width - padding,
          y: lineY + (lineRect.height - stringSize.height) / 2
        )

        lineNumberString.draw(at: drawPoint, withAttributes: attributes)
      }

      lineNumber += 1
      index = NSMaxRange(lineRange)
    }
  }
}
