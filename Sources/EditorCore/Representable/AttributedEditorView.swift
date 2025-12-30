//
//  Representible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools
import MarkdownHighlighter
import SwiftUI

public struct AttributedEditorView: NSViewRepresentable {
  @Environment(\.font) var swiftUIFont
  @Environment(\.fontResolutionContext) var fontResolutionContext
  @Environment(\.editorOptions) var editorOptions
  @Environment(\.lineSpacing) var lineSpacing

  @Binding var text: String

  var highlighter: MarkdownHighlighter

  public init(
    text: Binding<String>,
  ) {
    self._text = text
    self.highlighter = MarkdownHighlighter()
  }
}

extension AttributedEditorView {

  public func makeNSView(context: Context) -> NSScrollView {
    /// Create the scroll view container
    let scrollView = NSScrollView()
    setUpScrollView(scrollView)

    let textView = NSTextView()
    textView.textContentStorage?.delegate = context.coordinator
    textView.delegate = context.coordinator
    context.coordinator.textView = textView
    textView.setUpTextView()
    configureTextDefaults(
      textView,
      scrollWidth: scrollView.contentSize.width,
      context: context
    )
    context.coordinator.logTextKitMode(reason: "makeNSView")
    scrollView.documentView = textView
    handleLineNumbersIfNeeded(for: scrollView, textView: textView)

    return scrollView
  }

  // MARK: - SwiftUI Updated
  /// This is for communicating changes from SwiftUI back to AppKit

  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    guard let textView = scrollView.documentView as? NSTextView else { return }

    if textView.string != text {
      //      textView.needsLayout = true
      let selectedRange = textView.selectedRange()
      textView.string = text
      textView.setSelectedRange(selectedRange)
      context.coordinator.updateTextView()
    }

  }

  //  public func makeCoordinator() -> Coordinator {
  //    Coordinator(self)
  //  }

  //  private func getFont(with context: Context) -> NSFont {
  //    print("Let's try resolving the SwiftUI font from environment at \(Date.debug)")
  //    guard let font = context.environment.font else {
  //      print("⚠️ Couldn't get a font from the environment. Skipping.")
  //      return
  //    }
  //    print("Got font from the environment at \(Date.debug)")
  ////    let shouldUpdate: Bool = self.fontContext == nil || self.fontContext?.font != font
  ////    print("Local font context: \(String(describing: self.fontContext))")
  ////    guard shouldUpdate else {
  ////      print("No need to update. The font hasn't changed.")
  ////      return
  ////    }
  //    let fontResContext = context.environment.fontResolutionContext
  //    let fontContext = FontContext(font, context: fontResContext)
  ////    Task { @MainActor in
  ////      self.fontContext = fontContext
  ////    }
  //
  //    let resolved = fontContext.font.resolveCompatible(in: fontContext.context)
  //    return resolved.toNSFont
  //  }
  //
  //  var font: NSFont {
  //    let fallback = NSFont.systemFont(ofSize: 7)
  //    print("Checking font context at \(Date.debug): \(String(describing: fontContext))")
  //
  //    guard let fontContext else {
  //      print("No value for `fontContext`")
  //      return fallback
  //    }
  //    guard #available(macOS 26, iOS 26, *) else {
  //      print("macOS 26 not available, Falling back to less-preferred default font")
  //      return fallback
  //    }
  //    let resolved = fontContext.font.resolveCompatible(in: fontContext.context)
  //    return resolved.toNSFont
  //  }
}
