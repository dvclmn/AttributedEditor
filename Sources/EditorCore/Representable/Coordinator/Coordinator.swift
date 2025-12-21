//
//  Coordinator.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 14/8/2024.
//

import SwiftUI

extension AttributedEditorView {
  @MainActor
  public class Coordinator: NSObject, NSTextViewDelegate, @MainActor NSTextStorageDelegate
  {

    /// Stable bridge to SwiftUI
    let parent: AttributedEditorView

    /// Live AppKit object
    weak var textView: (any Highlightable)?
    //    var pendingEditedRange: NSRange?
    //    var isApplyingExternalUpdate = false

    public init(_ view: AttributedEditorView) {
      self.parent = view
    }

    /// Debouncing mechanism
    private var highlightWorkItem: DispatchWorkItem?
    //    var highlightTask: Task<Void, Never>?
  }
}

extension AttributedEditorView.Coordinator {
  // MARK: - Text Changed
  /// This is for communicating changes from within AppKit, back to SwiftUI
  public func textDidChange(_ notification: Notification) {
    //      guard let textView = notification.object as? Highlightable else { return }
    //      guard let textView = self.textView else { return }

    previousTextDidChangeApproach()

    //      parent.text = textView.string
    //      updateInsertionPointPosition(in: textView)
    //
    //      runHighlighting(for: textView)
    //      scheduleHighlight(for: textView)

    /// Update the binding immediately so SwiftUI stays in sync
    //      parent.text = textView.string
    //      updateInsertionPointPosition(in: textView)

    /// Cancel any pending highlight operation
    //      highlightWorkItem?.cancel()

    /// Schedule a new highlight operation after the debounce interval
    //      let workItem = DispatchWorkItem { [weak self] in

    //        self?.applyHighlighting(in: textView)
    //      }
    //      highlightWorkItem = workItem

    /// Execute after debounce interval on the main queue
    //      DispatchQueue.main.asyncAfter(
    //        deadline: .now() + parent.debounceInterval, execute: workItem)
  }

  // MARK: - Selection Changed
  /// This or communicating text selection changes from AppKit to SwiftUI
  public func textViewDidChangeSelection(_ notification: Notification) {
    //      guard let textView = notification.object as? Highlightable else { return }
    updateInsertionPointPosition()
  }

  //    public func textStorage(
  //      _ textStorage: NSTextStorage,
  //      didProcessEditing editedMask: NSTextStorageEditActions,
  //      range editedRange: NSRange,
  //      changeInLength delta: Int
  //    ) {
  //      guard editedMask.contains(.editedCharacters) else { return }
  //
  //      // Expand to whole lines (cheap + safe)
  //      let string = textStorage.string as NSString
  //      let lineRange = string.lineRange(for: editedRange)
  //
  //      pendingEditedRange = lineRange
  //    }

  private func previousTextDidChangeApproach() {
    guard let textView else { return }

    /// Update the binding immediately so SwiftUI stays in sync
    parent.text = textView.string
    updateInsertionPointPosition()

    /// Cancel any pending highlight operation
    highlightWorkItem?.cancel()

    /// Schedule a new highlight operation after the debounce interval
    let workItem = DispatchWorkItem { [weak self] in
      self?.previousApplyHighlightingApproach()
    }
    highlightWorkItem = workItem

    /// Execute after debounce interval on the main queue
    DispatchQueue.main.asyncAfter(
      deadline: .now() + parent.debounceInterval, execute: workItem)
  }
}
