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
    runs: AttributedRanges,
    textView: NSTextView,
    affectedRange: NSRange,
    font: NSFont,
    defaults: TextAttributes
  ) {

    guard let textStorage = textView.textStorage else { return }
    let text = textStorage.string

    textStorage.beginEditing()

//    var attrWithDebug = defaults
//    attrWithDebug.updateValue(
//      NSFont.monospacedSystemFont(ofSize: 13, weight: .medium), forKey: .font
//      NSColor.blue.withAlphaComponent(0.18), forKey: .backgroundColor
//    )

    //    print("Font attributes: ", thing.keys)

    textStorage.setAttributes(defaults, range: affectedRange)

    /// Apply each highlighted range's attributes
    for run in runs {
//      print("Run: \(run)")
      let range = run.nsRange(in: text)?.intersection(affectedRange)
      guard let range else { continue }
      
      var attrs = run.attributes
      
      let traits = attrs[.fontTraits] as? FontTraits
      let adjustedFont = traits?.constructFont(font: font, sizeScale: 0.94)
      
      attrs[.font] = adjustedFont
      
      textStorage.setAttributes(attrs, range: range)
      
    }

    textView.syncTypingAttributes()

    textStorage.endEditing()

  }

}
