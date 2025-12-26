//
//  Coordinator.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 14/8/2024.
//

import CoreTools
import HighlighterCommon
import SwiftUI

extension AttributedEditorView {
  // https://christiantietze.de/posts/2017/07/nstextview-proper-line-height/
  @MainActor
  public class Coordinator: NSObject,
    NSTextViewDelegate,
    //    @MainActor NSTextStorageDelegate,
    @MainActor NSTextContentStorageDelegate
  //    NSTextContentManagerDelegate
  {
    let parent: AttributedEditorView
    weak var textView: (any Highlightable)?
    //    var pendingEditedRange: NSRange?

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
    //    updateInsertionPointPosition()
    self.updateTextView()

    logTextKitMode(reason: "textDidChange")

  }

  // MARK: - Selection Changed
  /// This or communicating text selection changes from AppKit to SwiftUI
  public func textViewDidChangeSelection(_ notification: Notification) {
    /// Danger: this function seems to tank performance
    //    updateInsertionPointPosition()
  }

  public func textContentStorage(
    _ textContentStorage: NSTextContentStorage,
    textParagraphWith range: NSRange
  ) -> NSTextParagraph? {

    let tcs = textContentStorage
    guard let ts = tcs.textStorage else {
      print("No `tcs.textStorage` found")
      return nil
    }

    var attrParagraph: NSTextParagraph? = nil

    // First, get a copy of the paragraph from the original text storage.
    let originalText = ts.attributedSubstring(from: range)

    guard originalText.attribute(.codeBackground, at: 0, effectiveRange: nil) != nil else {
//      debugTCS(originalText: originalText, range: range)
      return nil
    }

    print("Found matches")
    let attrs: TextAttributes = [.backgroundColor: NSColor.systemMint.withAlphaComponent(0.3)]
    let attrText = NSMutableAttributedString(attributedString: originalText)

    /// The last character is the newline, second to last is the attachment character
    let attrRange = NSRange(location: 0, length: attrText.length - 2)
    attrText.addAttributes(attrs, range: attrRange)

    /// Create new paragraph with our display attributes.
    attrParagraph = NSTextParagraph(attributedString: attrText)

    //    return nil
    return attrParagraph
  }

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

  //  public func textStorage(
  //    _ textStorage: NSTextStorage,
  //    didProcessEditing editedMask: NSTextStorageEditActions,
  //    range editedRange: NSRange,
  //    changeInLength delta: Int
  //  ) {
  //
  ////    logTextKitMode(reason: "NSTextStorage/textStorage")
  //    guard editedMask.contains(.editedCharacters) else {
  //      //       print("`editedMask` did not contain .editedCharacters: \(editedMask)")
  //      return
  //    }
  //
  //    /// Expand to whole lines (cheap + safe)
  //    let string = textStorage.string as NSString
  //    let lineRange = string.lineRange(for: editedRange)
  //
  //    pendingEditedRange = lineRange
  //    //    print("Updated edited range to: \(lineRange) at \(Date.now.timeIntervalSince1970)")
  //  }

  //  public func layoutManager(
  //    _ layoutManager: NSLayoutManager,
  //    drawBackgroundForGlyphRange glyphsToShow: NSRange,
  //    at origin: CGPoint
  //  ) {
  //    // Get the attributed string
  //    guard let textStorage = layoutManager.textStorage,
  //          let tc = layoutManager.textContainers.first
  //    else { return }
  //
  //    // Enumerate attribute ranges within the glyph range
  //    textStorage.enumerateAttribute(
  //      .codeBackground,
  //      in: layoutManager.characterRange(forGlyphRange: glyphsToShow, actualGlyphRange: nil)
  //    ) { value, range, _ in
  //      guard value != nil else { return }
  //
  //      // Get the bounding rect(s) for the range
  //      layoutManager.enumerateEnclosingRects(
  //        forGlyphRange: layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil),
  //        withinSelectedGlyphRange: NSRange(location: NSNotFound, length: 0),
  //        in: tc
  //      ) { rect, _ in
  //        let path = NSBezierPath(roundedRect: rect.offsetBy(dx: origin.x, dy: origin.y), xRadius: 4, yRadius: 4)
  //        NSColor.systemYellow.setFill()
  //        path.fill()
  //      }
  //    }
  //  }

  //  public func drawBackground(forGlyphRange: ..., at: ...)

  //  public func layoutManager(
  //    _ layoutManager: NSLayoutManager,
  //    shouldUseTemporaryAttributes attrs: [NSAttributedString.Key: Any] = [:],
  //    forDrawingToScreen toScreen: Bool,
  //    atCharacterIndex charIndex: Int,
  //    effectiveRange: NSRangePointer?
  //  ) -> [NSAttributedString.Key: Any]? {
  //
  //    /// 1. Get the actual attributes from the text storage
  //    let fullAttributes = layoutManager.textStorage?.attributes(
  //      at: charIndex,
  //      effectiveRange: effectiveRange
  //    )
  //
  //
  ////    DebugString {
  ////      fullAttributes?.filter { key, value in
  ////        value is NSColor || value is FontTraits
  ////      }.names ?? "nil"
  ////    }
  //
  //    guard let traits = fullAttributes?[.fontTraits] else {
  ////      print("No traits found in the attributes")
  //      return nil
  //    }
  //
  //    guard let traits = traits as? FontTraits else {
  //      print("Could not cast to FontTraits")
  //      return nil
  //    }
  //
  ////    print("What are the new traits? \(traits)")
  //
  //    let currentFont = self.parent.font
  //    let adjustedFont = traits.constructFont(font: currentFont)
  //
  //    DebugString {
  //      Labeled("Previous font", value: currentFont.fontDescriptor)
  //      Labeled("New font", value: adjustedFont.fontDescriptor)
  //    }
  //
  //    var newAttributes = attrs
  //
  ////    newAttributes[.foregroundColor] = NSColor.systemPink
  ////    newAttributes[.font] = NSFont.monospacedSystemFont(ofSize: 14, weight: .bold)
  //    newAttributes[.font] = adjustedFont
  //    return newAttributes
  //
  //  }

}
