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
    tokens: NSAttributedRanges,
//    currentText: String,
    textView: NSTextView,
    affectedRange: NSRange,
    editorConfig: Editor.Configuration
  ) {
//  public func apply(
//    currentText: String,
//    textView: NSTextView,
//    editorConfig: Editor.Configuration
//  ) {

    guard let textStorage = textView.textStorage else { return }
//    let attrString = NSMutableAttributedString(string: currentText)
    
//    attrString.beginEditing()
//    textStorage.beginEditing()
    
    /// Set defaults
//    attrString.setAttributes(
//      defaultAttributes,
//      range: attrString.fullRange
//    )
    
    textStorage.setAttributes(defaultAttributes, range: affectedRange)

    /// Get highlighted ranges from the syntax highlighter
//    let attrRanges = self.buildStyles(
//      in: currentText
//    )

    /// Convert from `Range<String.Index>` to `NSRange`
//    let runs = tokens.toNSRanges(in: currentText)

    /// Apply each highlighted range's attributes
    for token in tokens {
      textStorage.addAttributes(token.attributes, range: token.range)
    }

//    textStorage.endEditing()

    /// Preserve the current cursor position and selection
//    let selectedRange = textView.selectedRange()

    
    /// Apply the attributed string to the text storage
//    textView.textStorage?.setAttributedString(attrString)
    

    /// Restore the cursor position
//    textView.setSelectedRange(selectedRange)
    

//    textView.syncTypingAttributes()

    /// Refresh line numbers
    if editorConfig.hasLineNumbers {
      textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true
      textView.needsDisplay = true
    }

  }

}
