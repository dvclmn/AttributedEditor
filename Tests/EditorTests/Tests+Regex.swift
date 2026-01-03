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
  func linkHasSixFragments() async throws {
    let text = "My link: [web site](http://website.com)"
    highlighter.supported = [.link]
    let runs = try highlighter.buildStyles(in: text)

    #expect(runs.count == 6)
    #expect(runs.content(for: .content(.label), in: text) == "web site")
    #expect(runs.content(for: .metadata(.url), in: text) == "http://website.com")
  }
  @Test
  func imageHasSevenFragments() async throws {
    let text = "My image: ![cool image](http://website.com/image.jpg)"
    highlighter.supported = [.image]
    let runs = try highlighter.buildStyles(in: text)

    #expect(runs.count == 7)
    #expect(runs.content(for: .content(.label), in: text) == "cool image")
    #expect(runs.content(for: .metadata(.url), in: text) == "http://website.com/image.jpg")
  }

  // MARK: - Italics
  //  @Test(arguments: ["*", "_"])
  //  func italicMatchesSupportedMarkers(marker: String) async throws {
  //    let text = "Some \(marker)example\(marker) text."
  //
  //    highlighter.supported = [.italic]
  //    let runs = try highlighter.buildStyles(in: text)
  //
  //    #expect(runs.count == 3)
  //    #expect(runs.contains(.italic))
  //    #expect(runs.textContent(for: .content, in: text) == "example")
  //  }

  //  @Test
  //  func imageHasSevenFragments() async throws {
  //    let text = "My image: ![hello](http://website.com/image.jpg)"
  //    highlighter.supported = [.image]
  //    let runs = try highlighter.buildStyles(in: text)
  //
  //    #expect(runs.count == 7)
  //  }
  //
  //  @Test
  //  func headingOneMatchesWithSpaceAfterHash() async throws {
  //    let text = "# An example of a header"
  //    highlighter.supported = [.heading(level: 1)]
  //    let runs = try highlighter.buildStyles(in: text)
  //
  //    #expect(runs.contains(.heading(level: 1)))
  //  }
  //
  //  @Test
  //  func headingOneDoesNotMatchWithoutSpaceAfterHash() async throws {
  //    let text = "#An example of a header"
  //    highlighter.supported = [.heading(level: 1)]
  //    let runs = try highlighter.buildStyles(in: text)
  //    #expect(runs.isEmpty)
  //  }
  //
  //  @Test
  //  func headingOneDoesNotMatchInHeadingTwo() async throws {
  //    let text = "## Header two, not header one"
  //    let runs = try highlighter.buildStyles(in: text)
  //    #expect(!runs.contains(.heading(level: 1)))
  //  }
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
