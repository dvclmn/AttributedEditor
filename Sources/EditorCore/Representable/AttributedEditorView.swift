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
    font: NSFont,
    /// Retiring this for now, until things are working better
    //    cursorPosition: Binding<InsertionPointPosition?> = .constant(nil),
    config: Editor.Configuration = .init(),
    highlighter: any Highlighter.Core,
    debounceInterval: TimeInterval = 0.1,
  ) {
    self._text = text
    self.font = font
    self._cursorPosition = .constant(nil)  // Turn this back on when ready
    self.editorConfig = config
    self.highlighter = highlighter
    self.debounceInterval = debounceInterval
  }
}

extension AttributedEditorView {

  public func makeNSView(context: Context) -> NSScrollView {
    /// Create the scroll view container
    let scrollView = NSScrollView()
    setUpScrollView(scrollView)

    /// Create and configure the text view
    let textView = BackingTextView()
    textView.delegate = context.coordinator
    textView.textStorage?.delegate = context.coordinator
    context.coordinator.textView = textView
    textView.setUpTextView(
      with: font,
      config: editorConfig,
      scrollViewWidth: scrollView.contentSize.width
    )

    scrollView.documentView = textView

    /// Add line numbers if enabled
    handleLineNumbers(for: scrollView, textView: textView)
    observeScroll(for: scrollView)

    return scrollView
  }

  // MARK: - SwiftUI Updated
  /// This is for communicating changes from SwiftUI back to AppKit
  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    guard let textView = scrollView.documentView as? Highlightable else { return }
    //    guard !context.coordinator.isApplyingExternalUpdate else { return }
//    print(
//      "SwiftUI triggered *general* `updateNSView` at \(Date.now.timeIntervalSince1970)")

    if textView.string != text {
//      DebugString {
//        "SwiftUI triggered `updateNSView` with text change at \(Date.now.timeIntervalSince1970)"
//        "AppKit character count: \(textView.string.count)"
//        "SwiftUI Binding character count: \(text.count)"
//        Divider()
//      }

      let selectedRange = textView.selectedRange()
      textView.string = text
      textView.setSelectedRange(selectedRange)
      context.coordinator.previousApplyHighlightingApproach()
    }
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  private func setUpScrollView(_ scrollView: NSScrollView) {
    scrollView.hasVerticalScroller = true
    scrollView.hasHorizontalScroller = false
    scrollView.autohidesScrollers = true
    scrollView.borderType = .noBorder
    scrollView.drawsBackground = false
  }

  public var defaultAttributes: TextAttributes {
    [
      .font: font,
      .foregroundColor: highlighter.theme.textColour,
    ]
  }

  private func handleLineNumbers(
    for scrollView: NSScrollView,
    textView: any Highlightable
  ) {
    if editorConfig.options.contains(.lineNumbers) {
      let rulerView = LineNumberRulerView(textView: textView)
      scrollView.verticalRulerView = rulerView
      scrollView.hasVerticalRuler = true
      scrollView.rulersVisible = true
    }
  }

  private func observeScroll(for scrollView: NSScrollView) {
    /// Post a notification when text view is scrolled so line numbers update
    NotificationCenter.default.addObserver(
      forName: NSView.boundsDidChangeNotification,
      object: scrollView.contentView,
      queue: .main
    ) { _ in
      Task { @MainActor in
//        print(
//          "AttributedEditor's scroll view did scroll/change. Visible rect:  \(scrollView.contentView.documentVisibleRect.debugDescription)"
//        )
        scrollView.verticalRulerView?.needsDisplay = true
      }
    }
  }

}
