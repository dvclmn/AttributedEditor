//
//  Editor+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 24/12/2025.
//

import AppKit
import CoreTools

extension AttributedEditorView {

  func configureTextDefaults(
    _ textView: Highlightable,
    scrollWidth: CGFloat,
    context: Context
  ) {
    let env = context.environment
    textView.isEditable = env.isEditable
    //    textView.isEditable = editorConfig.isEditable
    textView.setInsets(env.insets)
    textView.font = font
    textView.typingAttributes = defaultAttributes
    textView.defaultParagraphStyle = defaultParagraphStyle
    textView.textContainer?.containerSize = NSSize(
      width: scrollWidth,
      height: CGFloat.greatestFiniteMagnitude
    )
  }

  package func setUpScrollView(_ scrollView: NSScrollView) {
    scrollView.hasVerticalScroller = true
    scrollView.hasHorizontalScroller = false
    scrollView.autohidesScrollers = true
    scrollView.borderType = .noBorder
    scrollView.drawsBackground = false
  }

  var defaultParagraphStyle: NSMutableParagraphStyle {
    let paraStyle = NSMutableParagraphStyle()
    paraStyle.lineSpacing = editorConfig.lineSpacing
    return paraStyle
  }
  package var defaultAttributes: TextAttributes {
    return [
      .font: font,
      .foregroundColor: highlighter.theme.textColour,
      .paragraphStyle: defaultParagraphStyle,
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
    observeScroll(for: scrollView)
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

  var font: NSFont {
    guard #available(macOS 26, iOS 26, *), let swiftUIFont else {
      return NSFont.systemFont(ofSize: 14)
    }
    let resolved = swiftUIFont.resolveCompatible(in: fontResolutionContext)
    return resolved.toNSFont
  }

}
