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

  public init(
    _ text: Binding<String>,
    languageHint: LanguageHint
  ) {
    self._text = text
    self.languageHint = languageHint

    switch languageHint {
      /// Support for more to come
      default: self.highlighter = MarkdownHighlighter()
    }
  }

  public var body: some View {
    AttributedEditorView(
      text: $text,
      font: finalFont,
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

    .onAppear {
      if isPreview {
        print(digIntoResolvedFont)
      }
    }
    // TODO: Bring this back
    //    .onAppear {
    //      highlighter.updateTheme(markdownTheme)
    //    }
  }
}

extension AttributedEditor {
  private var finalFont: NSFont {
    guard #available(macOS 26, iOS 26, *), let font else {
      return NSFont.systemFont(ofSize: 14)
    }
    let resolved = font.resolveCompatible(in: fontResolutionContext)
    return resolved.toNSFont
  }

  private var digIntoResolvedFont: String {

    guard #available(macOS 26, iOS 26, *) else {
      return "Info only available on macOS 26 and above"
    }
    guard let font else { return "No font" }

    let resolved = font.resolveCompatible(in: fontResolutionContext)
    let nsFont = resolved.toNSFont

    let desc = nsFont.fontDescriptor

    return DisplayString {
      Labeled("Font from Env.", value: font)
      Labeled("Resolved", value: resolved)
      Labeled("Font Size", value: resolved.fontResolved.pointSize)
      Labeled("Font Descriptor", value: desc)
      Labeled("Attributes", value: desc.fontAttributes)
      Divider()
    }.plainText
    //  public var style: Font.TextStyle {
    //    return toNSFont.fontDescriptor.debugDescription

  }

  //    private var resolvedFontInfo: String {
  //      let resolved =
  //      let fallback = NSFont.systemFont(ofSize: 14)
  //      guard let compat = Font.Compatible(font: font, context: fontResolutionContext)
  //      else { return fallback }

  //    }
}
#if DEBUG
#Preview {
  @Previewable @State var text: String = DummyContent.Strings.paragraphsWithCode[1]
  AttributedEditor($text, languageHint: .markdown)
    .frame(width: 600, height: 690)
}
#endif
