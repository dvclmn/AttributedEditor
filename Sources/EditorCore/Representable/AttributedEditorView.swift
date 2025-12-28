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
    print("Here is the delegate for the text view (BEFORE): \(String(describing: controller.textView.delegate))")
    controller.textView.delegate = context.coordinator
    print("Here is the delegate for the text view (AFTER): \(String(describing: controller.textView.delegate))")
//    controller.textView.textStorage?.
//    controller.textDidChange = { [weak context.coordinator] newText in
//      context.coordinator?.textDidChange(to: newText)
//    }
    //    controller.textView.delegate = context.coordinator
    controller.textView.text = text

    //    handleLineNumbersIfNeeded(for: scrollView, textView: textView)

    return controller

  }

  // MARK: - SwiftUI Updated
  /// This is for communicating changes from SwiftUI back to AppKit
  package func updateNSViewController(_ controller: TextViewController, context: Context) {
    //  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    let textView = controller.textView
    //    guard  else { return }
    //
    if textView.string != text {
      let selectedRange = textView.selectedRange()
      textView.string = text
      textView.setSelectedRange(selectedRange)
      ////          context.coordinator.updateTextView()
    }
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}
