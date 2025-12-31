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

    let runs = try highlighter.buildStyles(in: asteriskText)

    let leadingRange = runs[0].range
    let leadingString = asteriskText[leadingRange]

    let trailingRange = runs[2].range
    let trailingString = asteriskText[trailingRange]
    //    let sameFragmentCount = runs.allSatisfy(\.)

    //    print("Number of runs: \(runs.count)")
    DebugString {
      Indented("Runs") {
        //        "\(dump(runs))"
        for run in runs {
          "\(run.range): \(asteriskText[run.range])"
        }
      }
    }
    //    #expect(runs)
    #expect(boldDesc?.shape == .wrap)
    #expect(leadingString == trailingString)
    //    #expect(runs.count == )

  }

}
