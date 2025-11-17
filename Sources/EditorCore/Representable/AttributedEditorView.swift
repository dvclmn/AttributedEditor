//
//  Representible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import HighlighterCommon
import SwiftUI

@MainActor
public struct AttributedEditorView: NSViewRepresentable {
  @Binding public var text: String
  @Binding var cursorPosition: InsertionPointPosition?
  var highlighter: any Highlighter
  let debounceInterval: TimeInterval

  public init(
    text: Binding<String>,
    cursorPosition: Binding<InsertionPointPosition?> = .constant(nil),
    highlighter: any Highlighter,
    debounceInterval: TimeInterval = 0.1,
  ) {
    self._text = text
    self._cursorPosition = cursorPosition
    self.highlighter = highlighter
    self.debounceInterval = debounceInterval
  }
}

extension AttributedEditorView {

  var config: Editor.Configuration { highlighter.editorConfig }
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
    textView.setUpTextView(config)

    textView.textContainer?.containerSize = NSSize(
      width: scrollView.contentSize.width,
      height: CGFloat.greatestFiniteMagnitude
    )

    /// Add line numbers if enabled
    if config.options.contains(.lineNumbers) {
      let rulerView = LineNumberRulerView(textView: textView)
      scrollView.verticalRulerView = rulerView
      scrollView.hasVerticalRuler = true
      scrollView.rulersVisible = true
    }

    scrollView.documentView = textView

    /// Store the text view in the coordinator for later access
    context.coordinator.textView = textView

    // Post a notification when text view is scrolled so line numbers update
    NotificationCenter.default.addObserver(
      forName: NSView.boundsDidChangeNotification,
      object: scrollView.contentView,
      queue: .main
    ) { _ in
      scrollView.verticalRulerView?.needsDisplay = true
    }

    return scrollView
  }

  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    guard let textView = scrollView.documentView as? BackingTextView else { return }

    /// Only update if the text has changed externally (not from typing)
    if textView.string != text {

      /// Preserve cursor position
      let selectedRange = textView.selectedRange()
      textView.string = text
      textView.setSelectedRange(selectedRange)

      /// Apply highlighting immediately for external changes
      context.coordinator.applyHighlighting()
    }
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

}
