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
//  @Test(arguments: ["*", "**"])
  func bold(_ characters: String) async throws {

    let bold = Markdown.Syntax.bold
    let text = "Some \(characters)example\(characters) text."

    highlighter.supported = [bold]

    let runs = try highlighter.buildStyles(in: text)

    print("Runs: ", runs)
    
    let lead = runs.text(0, in: text)
    let content = runs.text(1, in: text)
    let trail = runs.text(2, in: text)
    
    // This should be false
    let isItalic: Bool = lead == "*" || trail == "*"
    let isBold: Bool = lead == "**" 
    && trail == "**"
    && content == "example"
    
    if characters == "**" {
      #expect(isBold)
      #expect(!isItalic)
    } else {
      #expect(!isBold)
    }
    
//    #expect(!isItalic)
//    #expect(isBold)
//    #expect(bold.descriptor?.shape == .wrap)
//    #expect(lead == trail)
//    #expect(content == "example")

  }

}
