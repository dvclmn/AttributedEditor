//
//  RegexTests.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 20/8/2024.
//

import CoreTools
import RegexBuilder
import SwiftUI
import Testing

@testable import MarkdownHighlighter

typealias Syntax = Markdown.Syntax
struct RegexTests {
  let highlighter = MarkdownHighlighter()

  /// Pretending that only asterisk characters are valid, for now
  @Test(arguments: [
    Syntax.bold,
    Syntax.boldItalic,
    Syntax.italic,
  ])
  func asteriskSyntax(_ syntax: Syntax) async throws {

    let text = "Some **example** text."

    /// Assign the syntax from the Test arguments as supported
    let supported = Supported(
      syntax: [syntax],
      attributes: []
    )
    highlighter.supported = supported

    let runs = try highlighter.buildStyles(in: text)

    //    #expect(runs)
    let lead = runs.text(0, in: text)
    let content = runs.text(1, in: text)
    let trail = runs.text(2, in: text)
    #expect(syntax.descriptor?.shape == .wrap)
    #expect(lead == trail)
    #expect(content == "example")

    //    for run in runs {
    //
    //    }

    //    #expect(runs.count == )
  }

}
