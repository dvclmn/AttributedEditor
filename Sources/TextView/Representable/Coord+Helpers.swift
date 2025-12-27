//
//  Coord+Helpers.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit


extension AttributedEditorView.Coordinator {

  func updateTextView() {
    guard let textView else { return }
    let highlighter = self.parent.highlighter

    let text = textView.string
    let affectedRange = textView.documentNSRange

    Task {
      await self.debouncer.execute { @MainActor in

        let runs = highlighter.buildStyles(in: text)
        let defaults = self.parent.defaultAttributes

        highlighter.applyStyles(
          runs: runs,
          textView: textView,
          affectedRange: affectedRange,
          font: self.parent.font,
          defaults: defaults
        )

//        textView.updateHighlighter(with: highlighter)

        /// Refresh line numbers
        if self.parent.editorOptions.contains(.lineNumbers) {
          textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true
          textView.needsDisplay = true
        }
      }
    }
  }

  func logTextKitMode(reason: String, verboseLog: Bool = false) {
    guard let textView else { return }
    var debugText = ""
    if let _ = textView.textLayoutManager {
      /// Do nothing, only want to be alerted if not TK2
//      debugText = "🟢 TextKit 2 active (\(reason))"
//      if verboseLog {
//        debugText += " — textLayoutManager: \(tlm)"
//      }

    } else if let lm = textView.layoutManager {
      debugText = ("🔶 TextKit 1 compatibility mode (\(reason))")
      if verboseLog {
        debugText += " — layoutManager: \(lm)"
      }
    } else {
      debugText = ("⚠️ No layout manager detected (\(reason))")
    }
    print(debugText)
  }

  //  public func drawBackground(forGlyphRange glyphsToShow: NSRange, at origin: NSPoint) {
  //    print("Draw background")
  //    guard let textView,
  //      let textStorage = textView.textStorage,
  //      let layoutManager = textView.layoutManager,
  //      let textContainer = textView.textContainer
  //    else { return }
  //
  //    //    layoutManager.cha
  //    //    textStorage.
  //    let charRange = layoutManager.characterRange(
  //      forGlyphRange: glyphsToShow,
  //      actualGlyphRange: nil
  //    )
  //
  //    let highlighter = parent.highlighter
  //    //
  //    textStorage.enumerateAttribute(
  //      .codeBackground,
  //      in: charRange
  //    ) { value, range, _ in
  //
  //      print("Enumerating")
  //      guard let hasBackground = value as? Bool else { return }
  //
  //      if !hasBackground {
  //
  //        let rect = layoutManager.boundingRect(forGlyphRange: glyphsToShow, in: textContainer)
  //
  //        //    for range in highlighter {
  //        //    for range in highlighter.blockRanges {
  //        // Convert NSRange -> NSTextRange
  //        //        guard let textRange = self.textRange(for: range) else { continue }
  //
  //        // Calculate Rect using TextKit 2
  //        //        let rect = self.boundingRect(for: textRange)
  //
  //        guard !rect.isEmpty else { return }
  //
  //        let path = highlighter.drawBlockPath(in: rect)
  //        path.fill()
  //        path.stroke()
  //
  //      }
  //      // convert character range → glyph range
  //      //      let glyphRange = layoutManager.glyphRange(
  //      //        forCharacterRange: range,
  //      //        actualCharacterRange: nil
  //      //      )
  //
  //      // enumerate line fragments and draw
  //    }
  //  }

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

//}
