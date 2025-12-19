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
    let highlighter = self.parent.highlighter

    highlighter.apply(
      font: parent.font,
      currentText: textView.string,
      textView: textView,
//      defaults: self.parent.editorDefaults
    )
    textView.updateHighlighter(highlighter)

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
