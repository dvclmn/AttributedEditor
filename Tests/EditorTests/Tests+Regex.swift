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
    let asteriskText = "Some **bold** text."
    //    let syntaxes: [Markdown.Syntax] = [.bold, .italic, .boldItalic]
    //    let syntax = Markdown.Syntax.bold
    let bold = Markdown.Syntax.bold
    let boldDesc = bold.descriptor

    let supported = Supported(syntax: [.bold], attributes: [])
//    let supported = Supported(syntax: [.bold, .italic, .boldItalic], attributes: [])
    highlighter.supported = supported

    let runs = highlighter.buildStyles(in: asteriskText)
//    let sameFragmentCount = runs.allSatisfy(\.)
//    let
    
    print("Number of runs: \(runs.count)")
    //    #expect(runs)
    #expect(boldDesc?.shape == .wrap)
//    #expect(runs.count == )

  }

}
