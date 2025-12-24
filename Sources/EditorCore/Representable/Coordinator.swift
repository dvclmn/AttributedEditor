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
    let fullAttributes = layoutManager.textStorage?.attributes(at: charIndex, effectiveRange: effectiveRange)

//    print("Got the attributes: \(String(describing: fullAttributes))")
    // 2. Check if your custom key is present
    guard let traits = fullAttributes?[.fontTraits] as? FontTraits else {
      print("No traits found in the attributes")
      return nil
    }
    
//    print("What are the traits: \(traits)")

    let currentFont = self.parent.font
    let adjustedFont = traits.constructFont(font: currentFont)

    //    if let customValue = fullAttributes?[.customHighlight] as? Bool, customValue == true {
    var newAttributes = attrs
    // 3. Inject "Temporary Attributes" (standard keys)
    newAttributes[.font] = adjustedFont
//    newAttributes[.backgroundColor] = NSColor.yellow
//    newAttributes[.foregroundColor] = NSColor.black
    return newAttributes

  }

}
