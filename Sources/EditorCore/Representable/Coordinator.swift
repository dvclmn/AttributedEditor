//
//  Coordinator.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 14/8/2024.
//

import CoreTools
import SwiftUI

extension AttributedEditorView {
  // https://christiantietze.de/posts/2017/07/nstextview-proper-line-height/
  @MainActor
  public class Coordinator: NSObject,
    NSTextViewDelegate,
    @MainActor NSTextContentStorageDelegate
  {
    let parent: AttributedEditorView
    weak var textView: NSTextView?

    public init(_ view: AttributedEditorView) {
      self.parent = view
    }

    /// Debouncing mechanism
    let debouncer = AsyncDebouncer(interval: 0.1)
  }
}

extension AttributedEditorView.Coordinator {

  // MARK: - Text Changed
  /// This is for communicating changes from within AppKit, back to SwiftUI
  public func textDidChange(_ notification: Notification) {
    guard let textView else { return }

    /// Update the binding immediately so SwiftUI stays in sync
    parent.text = textView.string
    self.updateTextView()

    logTextKitMode(reason: "textDidChange")

  }

  // MARK: - Selection Changed
  /// This or communicating text selection changes from AppKit to SwiftUI
  public func textViewDidChangeSelection(_ notification: Notification) {
  }

//  public func textContentStorage(
//    _ textContentStorage: NSTextContentStorage,
//    textParagraphWith range: NSRange
//  ) -> NSTextParagraph? {
//
//    let tcs = textContentStorage
//    guard let ts = tcs.textStorage else {
//      print("No `tcs.textStorage` found")
//      return nil
//    }
//
//    var attrParagraph: NSTextParagraph? = nil
//
//    // First, get a copy of the paragraph from the original text storage.
//    let originalText = ts.attributedSubstring(from: range)
//
//    #warning("Will need to find another method for this codeBackground thing")
//    //    guard originalText.attribute(.codeBackground, at: 0, effectiveRange: nil) != nil else {
//    //      debugTCS(originalText: originalText, range: range)
//    //      return nil
//    //    }
//
//    print("Found matches")
//    let attrs: NSTextAttributes = [.backgroundColor: NSColor.systemMint.withAlphaComponent(0.3)]
//    let attrText = NSMutableAttributedString(attributedString: originalText)
//
//    /// The last character is the newline, second to last is the attachment character
//    let attrRange = NSRange(location: 0, length: attrText.length - 2)
//    attrText.addAttributes(attrs, range: attrRange)
//
//    /// Create new paragraph with our display attributes.
//    attrParagraph = NSTextParagraph(attributedString: attrText)
//
//    //    return nil
//    return attrParagraph
//  }

  private func debugTCS(
    originalText: NSAttributedString,
    range: NSRange
  ) {
    let someRange = originalText.string.indexRange
    let paragraphPreview = originalText.string[someRange]
    DebugString {
      "No `codeBackground` found in range: \(range)`"
      Labeled("Index Range", value: someRange)
      Labeled("Paragraph Preview", value: paragraphPreview)
      Labeled("Original Text", value: originalText)

    }
  }
}
