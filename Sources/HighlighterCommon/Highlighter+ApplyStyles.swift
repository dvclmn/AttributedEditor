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
  public func applyStyles(
    tokens: AttributedRanges,
    textView: NSTextView,
    affectedRange: NSRange,
    defaults: TextAttributes
  ) {

    guard let textStorage = textView.textStorage else { return }
    let text = textStorage.string

    textStorage.beginEditing()

    //    var attrWithDebug = defaults
    //    attrWithDebug.updateValue(
    //      NSColor.blue.withAlphaComponent(0.18), forKey: .backgroundColor
    //    )
    /// Reset
    textStorage.setAttributes(defaults, range: affectedRange)

    /// Apply each highlighted range's attributes
    for token in tokens {
      let range = token.nsRange(in: text)?.intersection(affectedRange)
      guard let range else { continue }
      textStorage.addAttributes(token.attributes, range: range)
    }

    textView.syncTypingAttributes()

    textStorage.endEditing()

  }

}
