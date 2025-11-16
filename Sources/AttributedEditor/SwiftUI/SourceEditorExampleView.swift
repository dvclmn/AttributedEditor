//
//  SourceEditorExampleView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import SwiftUI

struct ContentView: View {
  @State private var editorText = """
    let greeting = "Hello, World!"
    var count = 42

    func calculate() {
        let result = count + 10
        return result
    }

    This is some `inline code` within text.
    More code: `var x = 100`

    Try these features:
    - Select text and type ` or * or " to wrap it
    - Press Enter after a list item (like this one)
    - Press Enter between brackets: {}

    Keywords: let var func class struct enum if else for while return
    Numbers: 42, 3.14, 100
    Strings: "Hello" "Swift" "Test"
    """

  var body: some View {
    VStack(spacing: 0) {
      AttributedEditorView(
        text: $editorText,
//        cursorPosition: <#T##Binding<InsertionPointPosition?>#>,
        debounceInterval: <#T##TimeInterval#>,
        config: <#T##Editor.Configuration#>
      )
      // Editor with syntax highlighting
//      SourceEditorView(
//        text: $editorText,
////        highlighter: MarkdownSyntaxHighlighter(),
////        highlighter: BasicSyntaxHighlighter(),
//        debounceInterval: 0.3,
//        //        font: Font.body
//      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)

      Divider()

      // Info panel
      VStack(alignment: .leading, spacing: 4) {
        HStack {
          Text("Characters: \(editorText.count)")
            .font(.caption)
            .foregroundColor(.secondary)
          Spacer()
          Text("Syntax highlighting with 300ms debounce")
            .font(.caption)
            .foregroundColor(.secondary)
        }

        Text("Features: Selection wrapping (`, *, \", [], {}, ()), Auto-indent, Markdown lists")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding(8)
      .background(Color(NSColor.windowBackgroundColor))
    }
    .frame(minWidth: 600, minHeight: 400)
  }
}

#Preview {
  ContentView()
}
