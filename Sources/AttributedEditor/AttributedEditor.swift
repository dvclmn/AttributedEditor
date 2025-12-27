//
//  AttributedEditor.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import CoreTools
import EditorCore

import TextView
import MarkdownHighlighter
import SwiftUI

public struct AttributedEditor: View {
//  @Environment(\.insets) private var insets
//  @Environment(\.overScroll) private var overScroll
//  @Environment(\.isEditable) private var isEditable
//  @Environment(\.lineSpacing) private var lineSpacing
//  @Environment(\.font) private var font
//  @Environment(\.fontResolutionContext) private var fontResolutionContext

  @Binding var text: String

//   let highlighter: MarkdownHighlighter
//   let highlighter: any Highlighter

  public init(
    _ text: Binding<String>,
//    languageHint: LanguageHint
  ) {
    self._text = text

//    switch languageHint {
      /// Support for more to come
//      case .markdown:
//        self.highlighter = MarkdownHighlighter()
//      default:
//        print("Language '\(languageHint.rawValue)' not yet supported, defaulting to Markdown Highlighter for now")
//        self.highlighter = MarkdownHighlighter()
//    }
  }

  public var body: some View {
//    Text("Hello")
    AttributedEditorView(text: $text)
//            font: finalFont,
//      config: Editor.Configuration(
////        isEditable: isEditable,
//        options: [],
////        lineSpacing: lineSpacing,
//        insets: insets,
//        overScroll: overScroll,
//        maxWidth: nil
//      ),
//      highlighter: highlighter,

//    )

    .onAppear {
//      if isPreview {
//        print(digIntoResolvedFont)
//      }
    }

//    .task(id: font) {
//      highlighter.theme.updateFont(with: finalFont)
//    }
    // TODO: Bring this back
    //    .onAppear {
    //      highlighter.updateTheme(markdownTheme)
    //    }
  }
}


#if DEBUG
#Preview {
  @Previewable @State var text: String = DummyContent.Strings.paragraphsWithCode[1]
  AttributedEditor($text)
    .frame(width: 600, height: 690)
}
#endif
