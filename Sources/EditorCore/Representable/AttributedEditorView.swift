//
//  Representible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import CoreTools
import MarkdownHighlighter
import Neon
import SwiftUI

//struct AttributedEditorView: NSViewControllerRepresentable {
//  @Binding var text: String
//
//  func makeNSViewController(context: Context) -> TextViewController {
//    let controller = TextViewController()
//    // You may want to set initial text:
//    controller.textView.text = text
//    // Set delegates or handlers as needed
//    return controller
//  }
//
//  func updateNSViewController(_ controller: TextViewController, context: Context) {
//    // Sync from SwiftUI to controller if necessary
//    if controller.textView.text != text {
//      controller.textView.text = text
//    }
//    // Optionally, listen to changes on the NSTextView to update the binding
//    // via delegate or notification
//  }
//}

package struct AttributedEditorView: NSViewControllerRepresentable {
  package typealias NSViewControllerType = TextViewController
  //public struct AttributedEditorView: NSViewRepresentable {
//  @Environment(\.font) var swiftUIFont
//  @Environment(\.fontResolutionContext) var fontResolutionContext
//  @Environment(\.editorOptions) var editorOptions
//  @Environment(\.lineSpacing) var lineSpacing

  @Binding var text: String

//  var highlighter: MarkdownHighlighter = .init()
  //  var highlighter: any Highlighter

  public init(
    text: Binding<String>,
    //    highlighter: MarkdownHighlighter,
  ) {

    self._text = text
//    self.highlighter = MarkdownHighlighter()
  }
}

extension AttributedEditorView {

  package func makeNSViewController(context: Context) -> TextViewController {
    let controller = TextViewController()
    // You may want to set initial text:
            controller.textView.text = text
    // Set delegates or handlers as needed
    return controller
    //  public func makeNSView(context: Context) -> NSScrollView {
    /// Create the scroll view container
    //    let scrollView = NSScrollView()
    //    setUpScrollView(scrollView)

    /// Create and configure the text view
    //    let textSystem = TextViewSystemInterface(
    //      textView: <#T##TextView#>,
    //      attributeProvider: <#T##TokenAttributeProvider##TokenAttributeProvider##(Token) -> [NSAttributedString.Key : Any]#>
    //    )
    //    let textView = NSTextView()
    //    textView.updateHighlighter(with: highlighter)
    //    textView.textContentStorage?.delegate = context.coordinator
    //    textView.delegate = context.coordinator
    //    context.coordinator.textView = textView
    //    textView.setUpTextView()
    //    configureTextDefaults(
    //      textView,
    //      scrollWidth: scrollView.contentSize.width,
    //      context: context
    //    )
    //    context.coordinator.logTextKitMode(reason: "makeNSView")
    //
    //    scrollView.documentView = textView
    //
    //    handleLineNumbersIfNeeded(for: scrollView, textView: textView)

    //    return scrollView
  }

  // MARK: - SwiftUI Updated
  /// This is for communicating changes from SwiftUI back to AppKit
  package func updateNSViewController(_ controller: TextViewController, context: Context) {
    //  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    let textView = controller.textView
//    guard  else { return }
    //
        if textView.string != text {
//          let selectedRange = textView.selectedRange()
          textView.string = text
//          textView.setSelectedRange(selectedRange)
//          context.coordinator.updateTextView()
        }
  }

  //  public func makeCoordinator() -> Coordinator {
  //    Coordinator(self)
  //  }
}
