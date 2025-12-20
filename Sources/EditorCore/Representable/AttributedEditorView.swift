//
//  Representible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
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

    textView.setUpTextView(
      font: font,
      config: editorConfig,
    )

    textView.textContainer?.containerSize = NSSize(
      width: scrollView.contentSize.width,
      height: CGFloat.greatestFiniteMagnitude
    )

    /// Add line numbers if enabled
    if editorConfig.options.contains(.lineNumbers) {
      let rulerView = LineNumberRulerView(textView: textView)
      scrollView.verticalRulerView = rulerView
      scrollView.hasVerticalRuler = true
      scrollView.rulersVisible = true
    }

    scrollView.documentView = textView

    /// Store the text view in the coordinator for later access
//    context.coordinator.textView = textView

    /// Post a notification when text view is scrolled so line numbers update
    NotificationCenter.default.addObserver(
      forName: NSView.boundsDidChangeNotification,
      object: scrollView.contentView,
      queue: .main
    ) { _ in
      DispatchQueue.main.async {
        scrollView.verticalRulerView?.needsDisplay = true
      }
    }

    return scrollView
  }

  /// This is for communicating changes from SwiftUI back to AppKit
  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    guard let textView = scrollView.documentView as? Highlightable else { return }

    /// Only update if the text has changed externally (not from typing)
    if textView.string != text {

      /// Preserve cursor position
      let selectedRange = textView.selectedRange()
      textView.string = text
      textView.setSelectedRange(selectedRange)

      /// Apply highlighting immediately for external changes
      context.coordinator.applyHighlighting(in: textView)
    }
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

}
