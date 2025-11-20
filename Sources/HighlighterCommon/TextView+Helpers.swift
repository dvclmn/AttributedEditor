//
//  TextView+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension NSTextView {

  public func insertionPointPosition() -> InsertionPointPosition {
    return InsertionPointPosition.from(
      text: self.string,
      range: self.selectedRange()
    )
  }

  public func syncTypingAttributes() {
    let loc = selectedRange().location
    guard loc <= string.count, loc > 0 else { return }

    let pos = max(loc - 1, 0)
    if pos < textStorage?.length ?? 0,
      let attrs = textStorage?.attributes(at: pos, effectiveRange: nil)
    {
      typingAttributes = attrs
    }
  }

}
