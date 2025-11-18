//
//  Highlighter+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import CoreTools

extension AttributedRanges {
  public func withNSRanges(in text: String) -> [NSRange: [NSAttributedString.Key: Any]] {
    self.reduce(into: [:]) { result, element in
      result[element.key.toNSRange(in: text)] = element.value
    }
  }
}
extension Highlighter {

  @MainActor
  public func apply(
    currentText: String,
    textView: NSTextView,
    config: Editor.Configuration,
  ) {

    let attrString = NSMutableAttributedString(string: currentText)

    /// Apply default attributes to the entire text
    let defaultAttributes: [NSAttributedString.Key: Any] = [
      .font: config.defaultFont,
      .foregroundColor: config.defaultColour,
    ]
    attrString.setAttributes(defaultAttributes, range: attrString.fullRange)

    /// Get highlighted ranges from the syntax highlighter
    let highlightedRanges = self.highlight(text: currentText)

    /// Convert from `Range<String.Index>` to `NSRange`
    let ranges = highlightedRanges.withNSRanges(in: currentText)
    
    /// Apply each highlighted range's attributes
    for (range, attributes) in ranges {
      attrString.addAttributes(attributes, range: range)
    }

    /// Preserve the current cursor position and selection
    let selectedRange = textView.selectedRange()

    /// Apply the attributed string to the text storage
    textView.textStorage?.setAttributedString(attrString)

    /// Restore the cursor position
    textView.setSelectedRange(selectedRange)

    textView.syncTypingAttributes()
    
    /// Refresh line numbers
    textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true

  }
}
