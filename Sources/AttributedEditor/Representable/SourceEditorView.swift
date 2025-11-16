//
//  Representible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import SwiftUI
import HighlighterCommon

//public enum KnownHighlighters {
//  case basic
//  case markdown
//}

@MainActor
public struct AttributedEditorView: NSViewRepresentable {
  @Binding public var text: String
  @Binding var cursorPosition: InsertionPointPosition?
  var highlighter: any Highlighter
//  var inputBehaviors: [TextInputBehavior]
  let debounceInterval: TimeInterval
//  let fontSize: CGFloat
//  var showLineNumbers: Bool
  let config: Editor.Configuration

  public init(
    text: Binding<String>,
    cursorPosition: Binding<InsertionPointPosition?> = .constant(nil),
//    highlighter: any Highlighter,
//    highlighter: KnownHighlighters = .markdown,
    //    highlighter: Highlighter,
//    inputBehaviors: [TextInputBehavior] = [],
    debounceInterval: TimeInterval = 0.1,
    config: Editor.Configuration
//    fontSize: CGFloat = 14,
//    showLineNumbers: Bool = true,
  ) {
    self._text = text
    self._cursorPosition = cursorPosition
    self.highlighter = highlighter
//    self.highlighter = MarkdownHighlighter(fontSize: fontSize)
//    self.inputBehaviors = inputBehaviors
    self.debounceInterval = debounceInterval
    self.config = config
//    self.fontSize = fontSize
//    self.showLineNumbers = showLineNumbers
  }

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
      height:  CGFloat.greatestFiniteMagnitude
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

  //  public func makeCoordinator() -> Coordinator {
  //    Coordinator(
  //      text: $text,
  //      cursorPosition: $cursorPosition,
  //      highlighter: highlighter,
  //      inputBehaviors: inputBehaviors,
  //      debounceInterval: debounceInterval,
  ////      fontSize: fontSize
  //    )
  //  }

  static func editorFont(
    size: CGFloat = 15,
    weight: NSFont.Weight = .regular
  ) -> NSFont {
    NSFont.monospacedSystemFont(ofSize: size, weight: weight)
  }
}

//extension SourceEditorView {
  //  public var defaultTypingAttributes: Attributes {
  //    return [
  //      .font: defaultFont,
  //      .foregroundColor: theme.textColour.nsColour,
  //      .paragraphStyle: defaultParagraphStyle,
  //      TextBackground.inlineCode.attributeKey: false,
  //      TextBackground.codeBlock.attributeKey: false,
  //      TextBackground.highlight.attributeKey: false,
  //    ]
  //  }

  //  public var defaultParagraphStyle: NSParagraphStyle {
  //    let paragraphStyle = NSMutableParagraphStyle()
  //    paragraphStyle.lineSpacing = 1.8
  //
  //    return paragraphStyle
  //  }
//}
