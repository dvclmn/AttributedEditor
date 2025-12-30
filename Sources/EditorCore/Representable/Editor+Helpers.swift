//
//  Editor+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 24/12/2025.
//

import CoreTools
import SwiftUI

extension AttributedEditorView {

  func configureTextDefaults(
    _ textView: NSTextView,
    scrollWidth: CGFloat,
    context: Context
  ) {
    let env = context.environment
    textView.isEditable = env.isEditable
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

    paraStyle.lineSpacing = lineSpacing
    //    paraStyle.textLists = [
    //      .init(markerFormat: .circle, options: Int(NSTextList.Options.prependEnclosingMarker.rawValue))
    //    ]
    return paraStyle
  }

  package var defaultAttributes: NSTextAttributes {
    return [
      .font: font,
      //      .foregroundColor: highlighter.theme.textColour,
      .paragraphStyle: defaultParagraphStyle,
    ]
  }

  func debugUpdateNSView(_ textView: NSTextView) {
    DebugString {
      "SwiftUI triggered `updateNSView` with text change at \(Date.debug)"
      Divider()
    }
  }

  package func handleLineNumbersIfNeeded(
    for scrollView: NSScrollView,
    textView: NSTextView
  ) {
    if editorOptions.contains(.lineNumbers) {
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

  //    var font: NSFont {
  //      let fallback = NSFont.systemFont(ofSize: 7)
  //      print("Checking font context at \(Date.debug): \(String(describing: fontContext))")
  //
  //      guard let fontContext else {
  //        print("No value for `fontContext`")
  //        return fallback
  //      }
  //      guard #available(macOS 26, iOS 26, *) else {
  //        print("macOS 26 not available, Falling back to less-preferred default font")
  //        return fallback
  //      }
  //      let resolved = fontContext.font.resolveCompatible(in: fontContext.context)
  //      return resolved.toNSFont
  //    }

  func observeTextKitVersionChange(for textView: NSTextView) {

    /// Post a notification when text view is scrolled so line numbers update
    NotificationCenter.default.addObserver(
      forName: NSTextView.didSwitchToNSLayoutManagerNotification,
      object: textView,
      queue: .main
    ) { _ in
      Task { @MainActor in
        if textView.layoutManager != nil {
          print("🔶 Switched to TextKit 1 compatibility mode")
        }
      }
    }
  }
}

struct FontContext: Equatable {
  let font: Font
  let context: Font.Context
  init(_ font: Font, context: Font.Context) {
    self.font = font
    self.context = context
  }
}
