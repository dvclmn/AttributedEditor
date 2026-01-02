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

  @Test
  func headingOneMatchesWithSpaceAfterHash() async throws {
    let text = "# An example of a header"
    let runs = try highlighter.buildStyles(in: text)
    #expect(runs.contains(.heading(level: 1)))
  }

  @Test
  func headingOneDoesNotMatchWithoutSpaceAfterHash() async throws {
    let text = "#An example of a header"
    let runs = try highlighter.buildStyles(in: text)
    #expect(runs.isEmpty)
  }
  
  @Test
  func headingOneDoesNotMatchInHeadingTwo() async throws {
    let text = "## Header two, not header one"
    let runs = try highlighter.buildStyles(in: text)
    #expect(!runs.contains(.heading(level: 1)))
  }
  //  @Test(arguments: ["**"])
  //  func boldMatchesDoubleAsterisk(marker: String) async throws {
  //    let text = "Some \(marker)example\(marker) text."
  //
  //    highlighter.supported = [.bold]
  //    let runs = try highlighter.buildStyles(in: text)
  //
  //    #expect(runs.count == 3)
  //    #expect(runs[1].content(in: text) == "example")
  //  }
  //
  //  @Test(arguments: ["*"])
  //  func boldDoesNotMatchSingleAsterisk(marker: String) async throws {
  //    let text = "Some \(marker)example\(marker) text."
  //
  //    highlighter.supported = [.bold]
  //    let runs = try highlighter.buildStyles(in: text)
  //
  //    #expect(runs.isEmpty)
  //  }

  //  @Test(arguments: ["*", "_"])
  //  func italicMatchesSupportedMarkers(marker: String) async throws {
  //    let text = "Some \(marker)example\(marker) text."
  //
  //    highlighter.supported = [.italic]
  //    let runs = try highlighter.buildStyles(in: text)
  //
  //    #expect(runs.contains(.italic))
  //    #expect(runs[1].content(in: text) == "example")
  //  }
  //
  //  @Test(arguments: ["**", "__"])
  //  func italicDoesNotMatchDoubleMarkers(marker: String) async throws {
  //    let text = "Some \(marker)example\(marker) text."
  //
  //    highlighter.supported = [.italic]
  //    let runs = try highlighter.buildStyles(in: text)
  //
  //    #expect(!runs.contains(.italic))
  //  }

  //  @Test
  //  func italicDoesNotMatchInsideBold() async throws {
  //    let text = "Some **example** text."
  //
  //    highlighter.supported = [
  //      .italic,
  //      .bold,
  //    ]
  //    let runs = try highlighter.buildStyles(in: text)
  //
  //    print("Runs: \(runs.debugPreview(in: text))")
  //
  //    #expect(runs.contains(.bold))
  //    #expect(!runs.contains(.italic))
  //  }

}
