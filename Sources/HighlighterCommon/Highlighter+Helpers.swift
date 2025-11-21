//
//  Highlighter+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import CoreTools

extension Highlighter {

  @MainActor
  public func apply(
    currentText: String,
    textView: NSTextView,
    defaults: Editor.Defaults
//    config: Editor.Configuration,
  ) {
//  ) -> [NSRange] {

    let attrString = NSMutableAttributedString(string: currentText)
    setDefaultStyles(with: defaults, attrString: attrString)

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
    with defaults: Editor.Defaults,
//    with config: Editor.Configuration,
    attrString: NSMutableAttributedString
  ) {
    /// Apply default attributes to the entire text
    let defaultAttributes: TextAttributes = [
      .font: defaults.font,
      .foregroundColor: defaults.textColour,
    ]
    attrString.setAttributes(
      defaultAttributes,
      range: attrString.fullRange
    )
  }
}
