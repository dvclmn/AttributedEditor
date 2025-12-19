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
  @Environment(\.font) private var font
  @Environment(\.fontResolutionContext) private var fontResolutionContext

  @Binding var text: String
  let languageHint: LanguageHint
  let highlighter: any Highlighter.Core
//  let markdownHighlighter: MarkdownHighlighter
//  let fontSize: CGFloat

  public init(
    _ text: Binding<String>,
//    fontSize: CGFloat,
    languageHint: LanguageHint
  ) {
    self._text = text
//    self.fontSize = fontSize
    self.languageHint = languageHint
    
    switch languageHint {
      /// Support for more to come
      default: self.highlighter = MarkdownHighlighter()
    }
  }

  public var body: some View {
    AttributedEditorView(
      text: $text,
      font: NSFont.systemFont(ofSize: 14),
//      font: nsFont,
//      fontSize: fontSize,
      config: Editor.Configuration(
        isEditable: isEditable,
        options: [],
        lineSpacing: lineSpacing,
        insets: insets,
        overScroll: overScroll,
        maxWidth: nil
      ),
      highlighter: highlighter,

    )
    // TODO: Bring this back
//    .onAppear {
//      highlighter.updateTheme(markdownTheme)
//    }
  }
}

extension AttributedEditor {
  
//  private var nsFont: NSFont {
//    let fallback = NSFont.systemFont(ofSize: 14)
//    guard let compat = Font.Compatible(font: font, context: fontResolutionContext)
//    else { return fallback }
//    
//    let ctFont = compat.toNSFont(
//      <#T##style: Font.TextStyle##Font.TextStyle#>,
//      design: <#T##Font.Design?#>,
//      weight: <#T##Font.Weight?#>
//    )
//  }
}
#if DEBUG
#Preview {
  @Previewable @State var text: String = DummyContent.Strings.paragraphsWithCode[1]
  AttributedEditor($text, languageHint: .markdown)
    .frame(width: 600, height: 690)
}
#endif
