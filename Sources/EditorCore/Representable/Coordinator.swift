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
    @MainActor NSLayoutManagerDelegate
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
