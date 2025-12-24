//
//  Editor+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 24/12/2025.
//

import AppKit
import CoreTools

extension AttributedEditorView {

  package func setUpScrollView(_ scrollView: NSScrollView) {
    scrollView.hasVerticalScroller = true
    scrollView.hasHorizontalScroller = false
    scrollView.autohidesScrollers = true
    scrollView.borderType = .noBorder
    scrollView.drawsBackground = false
  }

  package var defaultAttributes: TextAttributes {
    let paraStyle = NSMutableParagraphStyle()
    paraStyle.lineSpacing = editorConfig.lineSpacing
    
    return [
      .font: font,
      .foregroundColor: highlighter.theme.textColour,
      .paragraphStyle: paraStyle,
    ]
  }

  func debugUpdateNSView(_ textView: Highlightable) {
    DebugString {
      "SwiftUI triggered `updateNSView` with text change at \(Date.debug)"
//      "AppKit character count: \(textView.string.count)"
//      "SwiftUI Binding character count: \(text.count)"
      Divider()
    }

  }

  package func handleLineNumbers(
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

  package func observeScroll(for scrollView: NSScrollView) {
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
