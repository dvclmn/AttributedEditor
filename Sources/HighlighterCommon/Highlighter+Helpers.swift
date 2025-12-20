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
    currentText: String,
    textView: NSTextView,
    editorConfig: Editor.Configuration
  ) {

    let attrString = NSMutableAttributedString(string: currentText)
    
    attrString.beginEditing()
    
    /// Set defaults
    attrString.setAttributes(
      defaultAttributes,
      range: attrString.fullRange
    )

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
    
    attrString.endEditing()

    textView.syncTypingAttributes()

    /// Refresh line numbers
    if editorConfig.hasLineNumbers {
      textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true
      textView.needsDisplay = true
    }

  }

}
