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

package struct AttributedEditorView: NSViewControllerRepresentable {

  //  package typealias NSViewControllerType = TextViewController
  //    @Environment(\.font) var swiftUIFont
  //  @Environment(\.fontResolutionContext) var fontResolutionContext
  //  @Environment(\.editorOptions) var editorOptions
  //  @Environment(\.lineSpacing) var lineSpacing

//  @State var fontContext: FontContext?
  //  @State private var font: NSFont
  //  @State package var swiftUIFont: Font?
  //  var swiftUIFont: Font?

//  @Binding var text: String

  //  var highlighter: MarkdownHighlighter = .init()
  //  var highlighter: any Highlighter

  public init(
//    text: Binding<String>,
    //    highlighter: MarkdownHighlighter,
  ) {
print("\n\n//// Booting up AttributedEditorView ////")
//    self._text = text
    //    self.highlighter = MarkdownHighlighter()
  }
}

extension AttributedEditorView {

  package func makeNSViewController(context: Context) -> TextViewController {
//    updateFont(with: context)
    let controller = TextViewController()
//      initialText: text,
//      font: font
    
    //    controller.textView.textStorage.
    //    print(
    //      "Here is the delegate for the text view (BEFORE): \(String(describing: controller.textView.delegate))")
    //    controller.textView.delegate = context.coordinator
    //    print(
    //      "Here is the delegate for the text view (AFTER): \(String(describing: controller.textView.delegate))")

    //    controller.textView.textStorage?.
    //    controller.textDidChange = { [weak context.coordinator] newText in
    //      context.coordinator?.textDidChange(to: newText)
    //    }
    //    controller.textView.delegate = context.coordinator
    //    controller.textView.text = text
    //    handleLineNumbersIfNeeded(for: scrollView, textView: textView)

    return controller

  }

  // MARK: - SwiftUI Updated
  /// This is for communicating changes from SwiftUI back to AppKit
  package func updateNSViewController(_ controller: TextViewController, context: Context) {
    //    let textView = controller.textView
    //    print("SwiftUI was updated.")
    //    print("Is there a difference between \(textView.string) and \(textView.textStorage?.string, default: "nil")")
    //  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    //    let textView = controller.textView
    //    guard  else { return }
    //
    //    if textView.string != text {
    //      let selectedRange = textView.selectedRange()
    //      textView.string = text
    //      textView.setSelectedRange(selectedRange)
    //      ////          context.coordinator.updateTextView()
    //    }
//        updateFont(with: context)

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
