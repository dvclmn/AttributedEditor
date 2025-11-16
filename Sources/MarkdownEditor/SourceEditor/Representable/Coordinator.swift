//
//  Coordinator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import SwiftUI

extension SourceEditorView {
  // MARK: - Coordinator

  @MainActor
  public class Coordinator: NSObject, NSTextViewDelegate {
    let parent: SourceEditorView
    weak var textView: BackgroundRenderingTextView?
    
    public init(_ view: SourceEditorView) {
      self.parent = view
    }
    
    /// Debouncing mechanism
    private var highlightWorkItem: DispatchWorkItem?
    
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
    
    public func textViewDidChangeSelection(_ notification: Notification) {
      updateInsertionPointPosition()
    }
  }

}
