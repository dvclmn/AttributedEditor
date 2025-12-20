//
//  Coord+Helpers.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import HighlighterCommon

extension AttributedEditorView.Coordinator {

  func applyHighlighting(in textView: any Highlightable) {
    let highlighter = self.parent.highlighter

    highlighter.apply(
      currentText: textView.string,
      textView: textView,
    )
    textView.updateHighlighter(with: highlighter)
  }

  func updateInsertionPointPosition(in textView: any Highlightable) {
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
