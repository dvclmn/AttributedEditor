//
//  Theme+Builder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit

extension Markdown.Theme {
  /// A helper to build definitions for a specific Syntax type
  struct SyntaxStyleBuilder {
    var content: TokenStyle?
    var syntax: TokenStyle?
    var background: NSColor? // Backgrounds are usually just colors, not fonts
    
    // Handle the whack-a-mole cases optionally
    var tint: TokenStyle? // For urls, language hints, callout icons, etc.
  }
  
  mutating func register(_ syntax: Markdown.Syntax, build: (inout SyntaxStyleBuilder) -> Void) {
    var builder = SyntaxStyleBuilder()
    build(&builder)
    
    var syntaxParts: [Markdown.SyntaxPart: TokenStyle] = [:]
    
    if let c = builder.content { syntaxParts[.content] = c }
    if let s = builder.syntax { syntaxParts[.syntaxChar] = s }
    if let bg = builder.background {
      // Encode background as a TokenStyle or handle separately
      syntaxParts[.background] = TokenStyle(color: bg)
    }
    
    // Map the "Extra" tint to the specific whack-a-mole part for this Syntax
    if let tint = builder.tint {
      switch syntax {
        case .link, .image: syntaxParts[.url] = tint
        case .codeBlock:    syntaxParts[.languageHint] = tint
        case .strikethrough: syntaxParts[.strikeLine] = tint
        case .callout:      syntaxParts[.calloutIcon] = tint
        default: break
      }
    }
    
    self.styles[syntax] = syntaxParts
  }
}
