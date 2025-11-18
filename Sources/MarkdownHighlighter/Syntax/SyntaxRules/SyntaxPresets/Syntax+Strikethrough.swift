//
//  Syntax+Strikethrough.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit
import ColourKit
import CoreTools

extension SyntaxRule where T == RegexShape.Three {
  static func strikethrough(
    fontSize: CGFloat,
    theme: Markdown.Theme,
  ) -> SyntaxRule {
    
    let pattern = /(?<leading>(?:\~{2}))(?<content>[^\n]+?)(?<trailing>\k<leading>)/
    let syntax: Markdown.Syntax = .strikethrough
    
    return SyntaxRule(
      syntax: syntax,
      pattern: pattern,
      theme: theme,
      exposesBlockRange: false
    ) { match, attrs in
      pattern.apply(
        match: match,
      ) {
        path,
        range in
        
        let font = NSFont.system(.bold, size: fontSize)
        
        switch path {
            
          case \.leading,
            \.trailing:
            attrs.update(.font, with: NSFont.system(.body, size: fontSize * 0.9, monospaced: true), in: range)
            attrs.update(.foregroundColor, with: NSColor.gray, in: range)
            
          case \.content:
            attrs.update(.font, with: font, in: range)
            
          default: return
        }
      }
    }
  }
}
