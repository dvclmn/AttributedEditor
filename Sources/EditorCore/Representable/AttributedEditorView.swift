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

public struct AttributedEditorView: NSViewRepresentable {
  @Environment(\.font) var swiftUIFont
  @Environment(\.fontResolutionContext) var fontResolutionContext
  @Environment(\.editorOptions) var editorOptions
  @Environment(\.lineSpacing) var lineSpacing
  @Binding public var text: String
  //  @Binding var cursorPosition: InsertionPointPosition?
  var highlighter: any Highlighter.Core
  //  let editorConfig: Editor.Configuration

  /// The goal is to populate this from the SwiftUI environment
  /// using Font.Resolved, and some mechanism for fallbacks
  /// for macOS versions older than macOS 26
  //  let font: NSFont

  public init(
    text: Binding<String>,
    //    font: NSFont,
    /// Retiring this for now, until things are working better
    //    cursorPosition: Binding<InsertionPointPosition?> = .constant(nil),
    //    config: Editor.Configuration = .init(),
    highlighter: any Highlighter.Core,
  ) {
    self._text = text
    //    self.font = font
    //    self._cursorPosition = .constant(nil)  // Turn this back on when ready
    //    self.editorConfig = config
    self.highlighter = highlighter
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
    textView.setUpTextView()
    configureTextDefaults(
      textView,
      scrollWidth: scrollView.contentSize.width,
      context: context
    )

    scrollView.documentView = textView

    /// Add line numbers if enabled
    handleLineNumbers(for: scrollView, textView: textView)

    return scrollView
  }

  // MARK: - SwiftUI Updated
  /// This is for communicating changes from SwiftUI back to AppKit
  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    guard let textView = scrollView.documentView as? Highlightable else { return }

    if textView.string != text {
      debugUpdateNSView(textView)
      let selectedRange = textView.selectedRange()
      textView.string = text
      textView.setSelectedRange(selectedRange)
      context.coordinator.updateTextView()
    }
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

}
