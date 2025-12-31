//
//  RegexTests.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 20/8/2024.
//

import RegexBuilder
import SwiftUI
import Testing

@testable import MarkdownHighlighter

@MainActor @Suite("Regex tests")

struct RegexTests {
  let highlighter = MarkdownHighlighter()

  @Test("Bold match")
  func bold() async throws {
    let text = "Some \(delimiter)bold\(delimiter) text."
    //    let syntaxes: [Markdown.Syntax] = [.bold, .italic, .boldItalic]
    //    let syntax = Markdown.Syntax.bold
    let bold = Markdown.Syntax.bold
    let boldDesc = bold.descriptor

    let supported = Supported(syntax: [.bold, .italic, .boldItalic], attributes: [])
    highlighter.supported = supported

    let runs = highlighter.buildStyles(in: text)

    //    #expect(runs)
    #expect(boldDesc?.shape == .wrap)

  }

}
