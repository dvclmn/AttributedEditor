//
//  AttributedEditor.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import CoreTools
import EditorCore
import HighlighterCommon
import MarkdownHighlighter
import SwiftUI

public struct AttributedEditor: View {
  @Environment(\.markdownTheme) private var markdownTheme
  @Binding var text: String
  let markdownHighlighter: MarkdownHighlighter

  public init(
    text: Binding<String>,
    fontSize: CGFloat = 14,
  ) {
    self._text = text

    let highlighter: MarkdownHighlighter = .init(
      config: .init(
        isEditable: true,
        options: [],
        //        options: [.lineNumbers],
        fontSize: fontSize,
        lineSpacing: 1.8,
        insets: CGSize(20, 40),
        overScroll: 80,
        maxWidth: nil,
        colours: .init()
      ),
    )
    self.markdownHighlighter = highlighter
  }

  public var body: some View {
    AttributedEditorView(text: $text, highlighter: markdownHighlighter)
      .onAppear {
        markdownHighlighter.updateTheme(markdownTheme)
      }

  }
}
#if DEBUG
#Preview {
  @Previewable @State var text: String = DummyContent.Strings.paragraphsWithCode[1]
  AttributedEditor(text: $text, fontSize: 14)
}
#endif

extension EnvironmentValues {
  @Entry public var markdownTheme: Markdown.Theme = .default
}

extension View where Self == AttributedEditor {
  public func setTheme(_ theme: Markdown.Theme) -> some View {
    self.environment(\.markdownTheme, theme)
  }
}
