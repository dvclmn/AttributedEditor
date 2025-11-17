//
//  SourceEditorExampleView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AttributedEditor
import CoreTools
import HighlighterCommon
import MarkdownHighlighter
import SwiftUI

struct EditorExampleView: View {
  @State private var cursorPosition: InsertionPointPosition? = nil
  let config: Editor.Configuration = .init()
  @State private var editorText: String = ""

  var body: some View {
    VStack(spacing: 0) {
      AttributedEditorView(
        text: $editorText,
        cursorPosition: $cursorPosition,
        highlighter: MarkdownHighlighter(config: config)
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)

      Divider()

      // Info panel
      VStack(alignment: .leading, spacing: 4) {
        HStack {
          Text("Characters: \(editorText.count)")
            .font(.caption)
            .foregroundColor(.secondary)
          Spacer()
        }
      }
      Font.largeTitle
      .padding(8)
      .background(Color(NSColor.windowBackgroundColor))
    }

    .background(Color.black.opacity(0.8))
    .onAppear {
      editorText = DummyContent.Strings.paragraphsWithCode[1]
    }
  }
}

#if DEBUG
#Preview {
  EditorExampleView()
    .frame(
      width: 600,
      height: 690,
      alignment: .leading
    )

}
#endif
