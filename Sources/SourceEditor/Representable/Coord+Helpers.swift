//
//  Coord+Helpers.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension SourceEditorView.Coordinator {

  private func updateInsertionPointPosition() {
    guard let textView else { return }
    let selectedRange = textView.selectedRange()

    DispatchQueue.main.async {
      self.parent.cursorPosition = calculateInsertionPointPosition(
        in: textView.string,
        range: selectedRange
      )
      
      /// Update typing attributes so new text matches existing style
      self.syncTypingAttributes()
    }
  }

  private func syncTypingAttributes() {
    guard let textView else { return }

    let loc = textView.selectedRange().location
    guard loc <= textView.string.count, loc > 0 else { return }

    let pos = max(loc - 1, 0)
    if pos < textView.textStorage?.length ?? 0,
      let attrs = textView.textStorage?.attributes(at: pos, effectiveRange: nil)
    {
      textView.typingAttributes = attrs
    }
  }

  /// Intercept keypresses to implement custom typing behaviors
  public func textView(
    _ textView: NSTextView, shouldChangeTextIn affectedCharRange: NSRange, replacementString: String?
  ) -> Bool {
    guard let replacementString = replacementString else {
      return true
    }

    /// Give each behavior a chance to handle the input
    for behavior in parent.inputBehaviors
    where behavior.handleKeyPress(
      character: replacementString,
      textView: textView,
      selectedRange: affectedCharRange
    ) {
      /// Behavior handled the input, prevent default processing
      return false
    }

    /// No behavior handled it, allow default processing
    return true
  }

  func applyHighlighting() {
    guard let textView else { return }

    let currentText = textView.string
    let attributedString = NSMutableAttributedString(string: currentText)

    /// Apply default attributes to the entire text
    let defaultAttributes: [NSAttributedString.Key: Any] = [
      .font: NSFont.systemFont(ofSize: parent.fontSize),
      .foregroundColor: NSColor.labelColor,
    ]
    attributedString.setAttributes(defaultAttributes, range: NSRange(location: 0, length: attributedString.length))

    /// Get highlighted ranges from the syntax highlighter
    let highlightedRanges = parent.highlighter.highlight(text: currentText)

    /// Apply each highlighted range's attributes
    for (range, attributes) in highlightedRanges {
      attributedString.addAttributes(attributes, range: range)
    }

    /// Preserve the current cursor position and selection
    let selectedRange = textView.selectedRange()

    /// Apply the attributed string to the text storage
    textView.textStorage?.setAttributedString(attributedString)

    /// Restore the cursor position
    textView.setSelectedRange(selectedRange)

    syncTypingAttributes()

    /// Update block background ranges
    let blockRanges = parent.highlighter.blockRanges(text: currentText)
    textView.updateBlockRanges(blockRanges)

    /// Refresh line numbers
    textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true

  }
}
