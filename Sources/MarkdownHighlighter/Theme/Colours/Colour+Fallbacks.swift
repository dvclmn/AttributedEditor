//
//  Colour+Fallbacks.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import ColourKit
import AppKit

/// Every element should declare either a fallback, or a 'nil' value.
/// P.s. if pink, this usually means it's placeholder / I'm not sure value
extension Markdown.Theme {
  static func fallbackColour(
    for syntax: Markdown.Syntax,
    kind: Markdown.ComponentKind
  ) -> NSColor? {
//  ) -> CodableColour? {
    let codable: CodableColour? = switch (syntax, kind) {
        
        //        case (_, .strikeText): strikeText
      case (_, .strikeLine): .red
      case (_, .languageHint): .secondary
      case (_, .url): .blue
      case (_, .calloutIcon): .primary
        
        /// Body content
      case (.body, .content): .primary
      case (.heading1, .content): .primary
      case (.heading2, .content): .primary
      case (.heading3, .content): .primary
      case (.heading4, .content): .primary
      case (.heading5, .content): .primary
      case (.heading6, .content): .primary
      case (.bold, .content): .primary
      case (.italic, .content): .primary
      case (.boldItalic, .content): .primary
      case (.inlineCode, .content): .secondary
      case (.codeBlock, .content): .secondary
      case (.list, .content): .primary
      case (.quoteBlock, .content): .primary
      case (.callout, .content): .primary
      case (.strikethrough, .content): .gray
      case (.highlight, .content): .cyan
      case (.link, .content): .pink
      case (.image, .content): .pink
      case (.horizontalRule, .content): .gray
        
        /// Syntax characters
      case (.body, .syntaxChar): .grey(0.6)
      case (.heading1, .syntaxChar): .grey(0.6)
      case (.heading2, .syntaxChar): .grey(0.6)
      case (.heading3, .syntaxChar): .grey(0.6)
      case (.heading4, .syntaxChar): .grey(0.6)
      case (.heading5, .syntaxChar): .grey(0.6)
      case (.heading6, .syntaxChar): .grey(0.6)
      case (.bold, .syntaxChar): .grey(0.6)
      case (.italic, .syntaxChar): .grey(0.6)
      case (.boldItalic, .syntaxChar): .grey(0.6)
      case (.inlineCode, .syntaxChar): .grey(0.6)
      case (.codeBlock, .syntaxChar): .grey(0.6)
      case (.list, .syntaxChar): .grey(0.6)
      case (.quoteBlock, .syntaxChar): .grey(0.6)
      case (.callout, .syntaxChar): .grey(0.6)
      case (.strikethrough, .syntaxChar): .grey(0.6)
      case (.highlight, .syntaxChar): .grey(0.6)
      case (.link, .syntaxChar): .grey(0.6)
      case (.image, .syntaxChar): .grey(0.6)
      case (.horizontalRule, .syntaxChar): .grey(0.6)
        
        /// Backgrounds, if needed
      case (.body, .background): nil
      case (.heading1, .background): nil
      case (.heading2, .background): nil
      case (.heading3, .background): nil
      case (.heading4, .background): nil
      case (.heading5, .background): nil
      case (.heading6, .background): nil
      case (.bold, .background): nil
      case (.italic, .background): nil
      case (.boldItalic, .background): nil
      case (.inlineCode, .background): .grey(0.2)
      case (.codeBlock, .background): .grey(0.2)
      case (.list, .background): nil
      case (.quoteBlock, .background): .pink
      case (.callout, .background): .pink
      case (.strikethrough, .background): nil
      case (.highlight, .background): .blue
      case (.link, .background): nil
      case (.image, .background): nil
      case (.horizontalRule, .background): nil
    }
    
    return codable?.nsColor
  }
}
