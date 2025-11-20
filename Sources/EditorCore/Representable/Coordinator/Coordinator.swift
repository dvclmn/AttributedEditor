//
//  Coordinator.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 14/8/2024.
//

//import BaseHelpers
import SwiftUI

extension AttributedEditorView {
  // MARK: - Coordinator

  @MainActor
  public class Coordinator: NSObject, NSTextViewDelegate {
    let parent: AttributedEditorView
    weak var textView: BackingTextView?

    public init(_ view: AttributedEditorView) {
      self.parent = view
    }

    /// Debouncing mechanism
    private var highlightWorkItem: DispatchWorkItem?

    // MARK: - Text Did Change
    /// This is for communicating changes from within AppKit, back to SwiftUI
    public func textDidChange(_ notification: Notification) {
      guard let textView = notification.object as? NSTextView else { return }

      /// Update the binding immediately so SwiftUI stays in sync
      parent.text = textView.string
      updateInsertionPointPosition()

      /// Cancel any pending highlight operation
      highlightWorkItem?.cancel()

      /// Schedule a new highlight operation after the debounce interval
      let workItem = DispatchWorkItem { [weak self] in
        self?.applyHighlighting()
      }
      highlightWorkItem = workItem

      /// Execute after debounce interval on the main queue
      DispatchQueue.main.asyncAfter(deadline: .now() + parent.debounceInterval, execute: workItem)
    }
    
    // MARK: - Text Did Change Selection
    /// This is for communicating text selection changes from AppKit to SwiftUI
    public func textViewDidChangeSelection(_ notification: Notification) {
      updateInsertionPointPosition()
    }
  }
}
