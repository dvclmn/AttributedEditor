//
//  Coordinator.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 14/8/2024.
//

import CoreTools
import SwiftUI

extension AttributedEditorView {
  //  // https://christiantietze.de/posts/2017/07/nstextview-proper-line-height/
  @MainActor
  public class Coordinator: NSObject, NSTextViewDelegate {
    //    //    @MainActor NSTextStorageDelegate,
    //    @MainActor NSTextContentStorageDelegate
    //  //    NSTextContentManagerDelegate
    //  {
    let parent: AttributedEditorView
    //    weak var textController: TextViewController?
    //    weak var textView: NSTextView?
    ////    weak var textView: (any Highlightable)?
    //    //    var pendingEditedRange: NSRange?
    //
    public init(_ view: AttributedEditorView) {
      self.parent = view
    }
    //
    //    /// Debouncing mechanism
    //    let debouncer = AsyncDebouncer(interval: 0.1)
  }
}
//
extension AttributedEditorView.Coordinator {

  //  // MARK: - Text Changed
    /// This is for communicating changes from within AppKit, back to SwiftUI
  public func textDidChange(_ notification: Notification) {
    guard let textView = notification.object as? NSTextView else { return }
    updateIfChanged(&self.parent.text, to: textView.string)
  }
}

//  // MARK: - Selection Changed
//  /// This or communicating text selection changes from AppKit to SwiftUI
//  public func textViewDidChangeSelection(_ notification: Notification) {
//    /// Danger: this function seems to tank performance
//    //    updateInsertionPointPosition()
//  }
//}
