//
//  File.swift
//
//
//  Created by Dave Coleman on 11/8/2024.
//

import SwiftUI
import Testing

@testable import EditorCore
@testable import MarkdownHighlighter

@MainActor
struct EditorTests {
  let highlighter: MarkdownHighlighter

  let font = NSFont.monospacedSystemFont(ofSize: 14, weight: .regular)

  @Test func findsInlineCode() {
//    textView.string = "I have a portion of `inline code` text."
//    let text = textView.string
//    let affectedRange = textView.documentNSRange
//
//    let runs = highlighter.buildStyles(in: text)
//
//    highlighter.applyStyles(
//      runs: runs,
//      textView: textView,
//      affectedRange: affectedRange,
//      font: font,
//      defaults: [:]
//    )

  }

}

//extension EditorTests {
//  init() {
//    let tv = BackingTextView()
//    let highlighter = MarkdownHighlighter()
//
//    tv.setUpTextView()
//    tv.highlighter = highlighter
////    tv.updateHighlighter(with: highlighter)
//    self.textView = tv
//    self.highlighter = highlighter
//  }
//
//  //  func makeEditor(withText text: String) -> AttributedEditorView {
//  //    let editor = AttributedEditorView(
//  //      text: .constant(text),
//  //      highlighter: self.highlighter
//  //    )
//  //
//  //    let hl = editor.high
//  //  }
//}

//
//@testable import MarkdownEditor
//
//
//@MainActor @Suite("MarkdownTextView tests", .disabled())
//
//
//  let textView = MarkdownTextView(frame: .zero, textContainer: nil, configuration: .init())
//
//  let exampleString = """
//    # Header
//
//    This is **bold** text.
//    """
//  let exampleString02 = "This has some **bold** text."
//
//
//
//}
//
//
//
//
//
//
//
//
//
//extension MarkdownTextViewTests {
//
//  @Test("Finds markdown matches at all", .disabled())
//  func findMarkdownMatches() async {
//
//    guard let tcm = textView.textLayoutManager?.textContentManager else { return }
//
//    textView.string = TestStrings.Markdown.anotherMarkdownString
//
//    //    await textView.parseMarkdown()
//
//    //    printCollection(textView.elements)
//
//  }
//
//}
//
