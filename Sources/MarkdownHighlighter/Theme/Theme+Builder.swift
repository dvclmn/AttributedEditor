//
//  Theme+Builder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import ColourKit

extension Markdown.Theme {
  struct SyntaxStyleBuilder {
    // MARK: - Core Storage
    // We store everything in the generic buckets
    var content: TokenStyle?
    var background: CodableColour?
    
    var leading: TokenStyle?
    var trailing: TokenStyle?
    var metadata: TokenStyle?
    
    // MARK: - Semantic Aliases
    
    /// Sets both leading and trailing syntax at once.
    var syntax: TokenStyle? {
      get { leading } // Return leading as representative
      set {
        leading = newValue
        trailing = newValue
      }
    }
    
    // The "Whack-a-mole" aliases
    // These all just read/write to `metadata`, but make the call site readable.
    
    /// Alias for `metadata` when configuring Links or Images
    var url: TokenStyle? {
      get { metadata }
      set { metadata = newValue }
    }
    
    /// Alias for `metadata` when configuring Code Blocks
    var languageHint: TokenStyle? {
      get { metadata }
      set { metadata = newValue }
    }
    
    /// Alias for `metadata` when configuring Callouts
    var icon: TokenStyle? {
      get { metadata }
      set { metadata = newValue }
    }
  }
  
  // The registration method maps the builder back to the generic parts
  mutating func register(_ syntax: Markdown.Syntax, build: (inout SyntaxStyleBuilder) -> Void) {
    var builder = SyntaxStyleBuilder()
    build(&builder)
    
    var parts: [Markdown.SyntaxPart: TokenStyle] = [:]
    
    if let c = builder.content { parts[.content] = c }
    if let l = builder.leading { parts[.syntaxLeading] = l }
    if let t = builder.trailing { parts[.syntaxTrailing] = t }
    if let m = builder.metadata { parts[.metadata] = m }
    
    if let bg = builder.background {
      parts[.background] = TokenStyle(colour: bg)
    }
    
    self.styles[syntax] = parts
  }
}
//extension Markdown.Theme {
//  /// A helper to build definitions for a specific Syntax type
//  struct SyntaxStyleBuilder {
//    var content: TokenStyle?
//    var syntax: TokenStyle?
//    var background: NSColor? // Backgrounds are usually just colors, not fonts
//    
//    // Handle the whack-a-mole cases optionally
//    var tint: TokenStyle? // For urls, language hints, callout icons, etc.
//  }
//  
//  mutating func register(_ syntax: Markdown.Syntax, build: (inout SyntaxStyleBuilder) -> Void) {
//    var builder = SyntaxStyleBuilder()
//    build(&builder)
//    
//    var syntaxParts: [Markdown.SyntaxPart: TokenStyle] = [:]
//    
//    if let c = builder.content { syntaxParts[.content] = c }
//    if let s = builder.syntax { syntaxParts[.syntaxChar] = s }
//    if let bg = builder.background {
//      // Encode background as a TokenStyle or handle separately
//      syntaxParts[.background] = TokenStyle(color: bg)
//    }
//    
//    // Map the "Extra" tint to the specific whack-a-mole part for this Syntax
//    if let tint = builder.tint {
//      switch syntax {
//        case .link, .image: syntaxParts[.url] = tint
//        case .codeBlock:    syntaxParts[.languageHint] = tint
//        case .strikethrough: syntaxParts[.strikeLine] = tint
//        case .callout:      syntaxParts[.calloutIcon] = tint
//        default: break
//      }
//    }
//    
//    self.styles[syntax] = syntaxParts
//  }
//}
