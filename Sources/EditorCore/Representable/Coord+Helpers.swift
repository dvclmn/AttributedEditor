//
//  Coord+Helpers.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import HighlighterCommon

extension AttributedEditorView.Coordinator {

  func updateTextView() {
    guard let textView else { return }
    let highlighter = self.parent.highlighter

    let text = textView.string
    let affectedRange = pendingEditedRange ?? textView.documentNSRange
    pendingEditedRange = nil

    Task {
      await self.debouncer.execute { @MainActor in

        let tokens = highlighter.buildStyles(
          in: text,
          with: self.parent.font
        )
        let defaults = self.parent.defaultAttributes

        highlighter.applyStyles(
          tokens: tokens,
          textView: textView,
          affectedRange: affectedRange,
          defaults: defaults
        )

        textView.updateHighlighter(with: highlighter)

        /// Refresh line numbers
        if self.parent.editorOptions.contains(.lineNumbers) {
          textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true
          textView.needsDisplay = true
        }
      }
    }

  }

  //  func updateInsertionPointPosition() {
  //    DispatchQueue.main.async {
  //      self.parent.cursorPosition = self.textView?.insertionPointPosition()
  //
  //      /// Update typing attributes so new text matches existing style
  //      self.textView?.syncTypingAttributes()
  //    }
  //  }

  //  func applyHighlighting(in textView: any Highlightable) {
  //    let highlighter = self.parent.highlighter
  //
  //    guard let textStorage = textView.textStorage else { return }
  //
  //    let affectedRange = pendingEditedRange ?? NSRange(location: 0, length: textStorage.length)
  //
  //    pendingEditedRange = nil
  //
  //    highlighter.apply(
  //      currentText: textStorage.string,
  //      textView: textView,
  //      affectedRange: affectedRange,
  //      editorConfig: self.parent.editorConfig
  //    )
  //    textView.updateHighlighter(with: highlighter)
  //  }

  //  func runHighlighting(for textView: NSTextView) {
  ////    highlightTask?.cancel()
  //    guard let textStorage = textView.textStorage else { return }
  //    let highlighter = self.parent.highlighter
  //    let config = self.parent.editorConfig
  //    let font = self.parent.font
  //    let textSnapshot = textView.string
  //    let affectedRange = pendingEditedRange ?? NSRange(location: 0, length: textStorage.length)
  //
  ////    highlightTask = Task { @MainActor in
  ////      try? await Task.sleep(for: .seconds(0.15))
  //
  ////      guard !Task.isCancelled else { return }
  //
  //      //      let tokens = await self.parent.highlighter.parse(textSnapshot)
  //    let tokens = highlighter.buildStyles(in: textSnapshot, with: font)
  //
  ////      await MainActor.run {
  ////        guard !Task.isCancelled else { return }
  //        highlighter.apply(
  //          tokens: tokens,
  //          textView: textView,
  //          affectedRange: affectedRange,
  //          editorConfig: config,
  //          defaults: parent.defaultAttributes
  //        )
  //        //        apply(tokens, to: textView, affectedRange: affectedRange)
  ////      }
  ////    }
  //  }

  //  func scheduleHighlight(for textView: NSTextView) {
  //    highlightTask?.cancel()
  //    guard let textStorage = textView.textStorage else { return }
  //    let highlighter = self.parent.highlighter
  //    let config = self.parent.editorConfig
  //    let textSnapshot = textView.string
  //    let affectedRange = pendingEditedRange ?? NSRange(location: 0, length: textStorage.length)
  //
  //    highlightTask = Task { @MainActor in
  //      try? await Task.sleep(for: .seconds(0.15))
  //
  //      guard !Task.isCancelled else { return }
  //
  ////      let tokens = await self.parent.highlighter.parse(textSnapshot)
  //      let tokens = highlighter.buildStyles(in: textSnapshot)
  //
  //      await MainActor.run {
  //        guard !Task.isCancelled else { return }
  //        highlighter.apply(
  //          tokens: tokens,
  //          textView: textView,
  //          affectedRange: affectedRange,
  //          editorConfig: config
  //        )
  ////        apply(tokens, to: textView, affectedRange: affectedRange)
  //      }
  //    }
  //  }

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
