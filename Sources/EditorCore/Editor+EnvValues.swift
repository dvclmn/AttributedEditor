//
//  Editor+EnvValues.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI
import MarkdownHighlighter

extension EnvironmentValues {
//  @Entry public var markdownTheme: Markdown.Theme = .default
  @Entry public var insets: CGSize = CGSize(10, 20)
  @Entry public var overScroll: Int = 20
  
  /// I think this may be a native value, not sure
  @Entry public var lineSpacing: CGFloat = 1.4
  @Entry public var editorOptions: Editor.Options = []
  
}

//extension View where Self == AttributedEditor {
//  public func setTheme(_ theme: Markdown.Theme) -> some View {
//    self.environment(\.markdownTheme, theme)
//  }
//}
