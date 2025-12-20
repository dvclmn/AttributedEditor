//
//  Representible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools
import HighlighterCommon
import Sharing
import SwiftUI

@MainActor
public struct AttributedEditorView: NSViewRepresentable {
  @Binding public var text: String
  @Binding var cursorPosition: InsertionPointPosition?
  var highlighter: any Highlighter.Core
  let editorConfig: Editor.Configuration
  let debounceInterval: TimeInterval

  /// The goal is to populate this from the SwiftUI environment
  /// using Font.Resolved, and some mechanism for fallbacks
  /// for macOS versions older than macOS 26
  let font: NSFont

  public init(
    text: Binding<String>,
    font: NSFont = .systemFont(ofSize: 14),
    cursorPosition: Binding<InsertionPointPosition?> = .constant(nil),
    config: Editor.Configuration = .init(),
    highlighter: any Highlighter.Core,
    debounceInterval: TimeInterval = 0.1,
  ) {
    self._text = text
    self.font = font
    self._cursorPosition = cursorPosition
    self.editorConfig = config
    self.highlighter = highlighter
    self.debounceInterval = debounceInterval
  }
}

extension AttributedEditorView {

  public func makeNSView(context: Context) -> NSScrollView {
    /// Create the scroll view container
    let scrollView = NSScrollView()
    scrollView.hasVerticalScroller = true
    scrollView.hasHorizontalScroller = false
    scrollView.autohidesScrollers = true
    scrollView.borderType = .noBorder
    scrollView.drawsBackground = false

    /// Create and configure the text view
    let textView = BackingTextView()
    textView.delegate = context.coordinator
    textView.textStorage?.delegate = context.coordinator

    textView.setUpTextView(
      font: font,
      config: editorConfig,
    )

    textView.textContainer?.containerSize = NSSize(
      width: scrollView.contentSize.width,
      height: CGFloat.greatestFiniteMagnitude
    )
    scrollView.documentView = textView

    /// Add line numbers if enabled
    if editorConfig.options.contains(.lineNumbers) {
      let rulerView = LineNumberRulerView(textView: textView)
      scrollView.verticalRulerView = rulerView
      scrollView.hasVerticalRuler = true
      scrollView.rulersVisible = true

      NotificationCenter.default.addObserver(
        forName: NSView.boundsDidChangeNotification,
        object: scrollView.contentView,
        queue: .main
      ) { _ in
        DispatchQueue.main.async {
          scrollView.verticalRulerView?.needsDisplay = true
        }
      }
    }

    /// Store the text view in the coordinator for later access
    //    context.coordinator.textView = textView

    /// Post a notification when text view is scrolled so line numbers update

    return scrollView
  }

  // MARK: - SwiftUI Updated
  /// This is for communicating changes from SwiftUI back to AppKit
  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    guard let textView = scrollView.documentView as? Highlightable else { return }
    //    guard !context.coordinator.isApplyingExternalUpdate else { return }
    print("SwiftUI triggered *general* `updateNSView` at \(Date.now.timeIntervalSince1970)")
    
    if textView.string != text {
      DebugString {
        "SwiftUI triggered `updateNSView` with text change at \(Date.now.timeIntervalSince1970)"
        "AppKit character count: \(textView.string.count)"
        "SwiftUI Binding character count: \(text.count)"
        Divider()
      }

      //      context.coordinator.isApplyingExternalUpdate = true

      let selectedRange = textView.selectedRange()
      textView.string = text
      textView.setSelectedRange(selectedRange)
      context.coordinator.runHighlighting(for: textView)
      //      context.coordinator.isApplyingExternalUpdate = false
    }

    //    if textView.string != text {
    //
    //      /// Preserve cursor position
    //      let selectedRange = textView.selectedRange()
    //      textView.string = text
    //      textView.setSelectedRange(selectedRange)
    //
    //      /// Apply highlighting immediately for external changes
    //          context.coordinator.applyHighlighting(in: textView)
    //    }
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

}
