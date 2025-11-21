//
//  Syntax+InlineCode.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 17/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension Markdown.SyntaxRule where T == RegexShape.Wrap {
  
  static var inlineCode: Self {
    
    let pattern = /(?<leading>`)(?<content>(?:[^`\n])+?)(?<trailing>`)/
    let syntax: Markdown.Syntax = .inlineCode
    
    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      exposesBlockRange: false
    )
  }
}
