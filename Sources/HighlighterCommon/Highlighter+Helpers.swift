//
//  Highlighter+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import CoreTools

extension Highlighter.Core {

  @MainActor
  public func apply(
    font: NSFont,
    currentText: String,
    textView: NSTextView,
  ) {

    let attrString = NSMutableAttributedString(string: currentText)
    setDefaultStyles(font: font, attrString: attrString)

    /// Get highlighted ranges from the syntax highlighter
    let attrRanges = self.buildStyles(
      in: currentText
    )

    /// Convert from `Range<String.Index>` to `NSRange`
    let runs = attrRanges.toNSRanges(in: currentText)

    /// Apply each highlighted range's attributes
    for run in runs {
      attrString.addAttributes(run.attributes, range: run.range)
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

    textView.needsDisplay = true

//    return markdownStyles.blocks.map {
//      $0.toNSRange(in: currentText)
//    }

  }

  /// Note: even though it feels weird, `attrString` can
  /// still be mutated, even though it's not being passed
  /// as an `inout` parameter, because it is a class.
  private func setDefaultStyles(
    font defaultFont: NSFont,
    attrString: NSMutableAttributedString
  ) {
    /// Apply default attributes to the entire text
    let defaultAttributes: TextAttributes = [
      .font: defaultFont,
      .foregroundColor: NSColor.textColor,
    ]
    attrString.setAttributes(
      defaultAttributes,
      range: attrString.fullRange
    )
  }
}
