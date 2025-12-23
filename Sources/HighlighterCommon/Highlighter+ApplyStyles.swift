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
    tokens: AttributedRanges,
    textView: NSTextView,
    affectedRange: NSRange,
    editorConfig: Editor.Configuration,
    defaults: TextAttributes
  ) {

    guard let textStorage = textView.textStorage else { return }
    let text = textStorage.string

    textStorage.beginEditing()

    var finalAttributes = defaults
    finalAttributes.updateValue(
      NSColor.blue.withAlphaComponent(0.18), forKey: .backgroundColor
    )
    textStorage.setAttributes(finalAttributes, range: affectedRange)

    /// Apply each highlighted range's attributes
    for token in tokens {
      guard let range = token.nsRange(in: text)?.intersection(affectedRange) else {
        continue
      }

      textStorage.addAttributes(token.attributes, range: range)
    }

    textStorage.endEditing()

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
