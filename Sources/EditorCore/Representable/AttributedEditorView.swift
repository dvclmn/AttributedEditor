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
//  var highlighter: any Highlighter

  public init(
    text: Binding<String>,
//    highlighter: MarkdownHighlighter,
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

    /// Create and configure the text view
    let textView = BackingTextView()
//    textView.updateHighlighter(with: highlighter)
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
    guard let textView = scrollView.documentView as? Highlightable else { return }

    if textView.string != text {
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
