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
  @Environment(\.insets) private var insets
  @Environment(\.overScroll) private var overScroll
  @Environment(\.isEditable) private var isEditable
  @Environment(\.lineSpacing) private var lineSpacing

  @Binding var text: String
  let languageHint: LanguageHint
  let highlighter: any Highlighter.Core
//  let markdownHighlighter: MarkdownHighlighter
  let fontSize: CGFloat

  public init(
    text: Binding<String>,
    fontSize: CGFloat,
    languageHint: LanguageHint
  ) {
    self._text = text
    self.fontSize = fontSize
    self.languageHint = languageHint
    
    switch languageHint {
      /// Support for more to come
      default: self.highlighter = MarkdownHighlighter()
    }
  }

  public var body: some View {
    AttributedEditorView(
      text: $text,
      fontSize: fontSize,
      config: Editor.Configuration(
        isEditable: isEditable,
        options: [.lineNumbers],
        lineSpacing: lineSpacing,
        insets: insets,
        overScroll: overScroll,
        maxWidth: nil
      ),
      highlighter: highlighter,

    )
    .onAppear {
      highlighter.updateTheme(markdownTheme)
    }
  }
}
#if DEBUG
#Preview {
  @Previewable @State var text: String = DummyContent.Strings.paragraphsWithCode[1]
  AttributedEditor(text: $text, fontSize: 21)
    .frame(width: 600, height: 690)
}
#endif
