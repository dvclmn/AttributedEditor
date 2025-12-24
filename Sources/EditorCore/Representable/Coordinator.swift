//
//  Coordinator.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 14/8/2024.
//

import CoreTools
import SwiftUI
import HighlighterCommon

extension AttributedEditorView {
  // https://christiantietze.de/posts/2017/07/nstextview-proper-line-height/
  @MainActor
  public class Coordinator: NSObject,
    NSTextViewDelegate,
    @MainActor NSTextStorageDelegate,
    @MainActor NSLayoutManagerDelegate
  {
    let parent: AttributedEditorView
    weak var textView: (any Highlightable)?
    var pendingEditedRange: NSRange?

    public init(_ view: AttributedEditorView) {
      self.parent = view
    }

    /// Debouncing mechanism
    let debouncer = AsyncDebouncer(interval: 0.2)
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

  }

  // MARK: - Selection Changed
  /// This or communicating text selection changes from AppKit to SwiftUI
  public func textViewDidChangeSelection(_ notification: Notification) {
    //    updateInsertionPointPosition()
  }

  public func textStorage(
    _ textStorage: NSTextStorage,
    didProcessEditing editedMask: NSTextStorageEditActions,
    range editedRange: NSRange,
    changeInLength delta: Int
  ) {
    guard editedMask.contains(.editedCharacters) else {
      //       print("`editedMask` did not contain .editedCharacters: \(editedMask)")
      return
    }

    /// Expand to whole lines (cheap + safe)
    let string = textStorage.string as NSString
    let lineRange = string.lineRange(for: editedRange)

    pendingEditedRange = lineRange
    //    print("Updated edited range to: \(lineRange) at \(Date.now.timeIntervalSince1970)")
  }

  public var fixesAttributesLazily: Bool { true }

  public func layoutManager(
    _ layoutManager: NSLayoutManager,
    shouldUseTemporaryAttributes attrs: [NSAttributedString.Key: Any] = [:],
    forDrawingToScreen toScreen: Bool,
    atCharacterIndex charIndex: Int,
    effectiveRange: NSRangePointer?
  ) -> [NSAttributedString.Key: Any]? {

    /// 1. Get the actual attributes from the text storage
    let fullAttributes = layoutManager.textStorage?.attributes(
      at: charIndex,
      effectiveRange: effectiveRange
    )

//    DebugString {
//      fullAttributes?.filter { key, value in
//        value is NSColor || value is FontTraits
//      }.names ?? "nil"
//    }

    guard let traits = fullAttributes?[.fontTraits] else {
      print("No traits found in the attributes")
      return nil
    }
    
    guard let traits = traits as? FontTraits else {
      print("Could not cast to FontTraits")
      return nil
    }


    let currentFont = self.parent.font
    let adjustedFont = traits.constructFont(font: currentFont)

    var newAttributes = attrs
    
    newAttributes[.font] = adjustedFont
    return newAttributes

  }

}
