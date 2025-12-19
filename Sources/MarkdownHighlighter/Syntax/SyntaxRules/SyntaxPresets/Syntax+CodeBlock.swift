//
//  Syntax+CodeBlock.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension Markdown.SyntaxRule where T == RegexShape.CodeBlock {
  
  static var codeBlock: Self {
    
    let pattern = /(?<start>```[ \t]*)(?<langHint>[^\n]*)\n(?<content>(?:.|\n)*?)(?<end>^```[ \t]*$)/
      .dotMatchesNewlines()
      .anchorsMatchLineEndings()

    return SyntaxRule(for: .codeBlock, pattern: pattern)
  }
}

