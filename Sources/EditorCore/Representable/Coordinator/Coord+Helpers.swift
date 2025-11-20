//
//  Coord+Helpers.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import HighlighterCommon

extension AttributedEditorView.Coordinator {
  
  func applyHighlighting() {
    guard let textView else { return }
    let currentText = textView.string
    let highlighter = self.parent.highlighter

    let blockRanges = highlighter.apply(
      currentText: currentText,
      textView: textView,
      config: self.parent.config
    )
    textView.updateBlockRanges(blockRanges)

  }

  func updateInsertionPointPosition() {
    guard let textView else { return }

    DispatchQueue.main.async {
      self.parent.cursorPosition = textView.insertionPointPosition()

      /// Update typing attributes so new text matches existing style
      textView.syncTypingAttributes()
    }
  }

  /// Intercept keypresses to implement custom typing behaviors
  /// Note: This will eventually use `TextInputBehavior/handleTextChange()`
  //  public func textView(
  //    _ textView: NSTextView,
  //    shouldChangeTextIn affectedCharRange: NSRange,
  //    replacementString: String?
  //  ) -> Bool {
  //
  //  }

}
