//
//  Colour+Fallbacks.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

import ColourKit

/// Every element should declare either a fallback, or a 'nil' value
extension Markdown.Theme {
  func fallbackColour(
    for syntax: Markdown.Syntax,
    kind: Markdown.ComponentKind
  ) -> CodableColour? {
    switch (syntax, kind) {
        
        //        case (_, .strikeText): strikeText
      case (_, .strikeLine): strikeLine
      case (_, .languageHint): body
      case (_, .url): url
      case (_, .calloutIcon): body
        
        /// Body content
      case (.body, .content): body
      case (.heading1, .content): body
      case (.heading2, .content): body
      case (.heading3, .content): body
      case (.heading4, .content): body
      case (.heading5, .content): body
      case (.heading6, .content): body
      case (.bold, .content): body
      case (.italic, .content): body
      case (.boldItalic, .content): body
      case (.inlineCode, .content): inlineCode
      case (.codeBlock, .content): codeBlock
      case (.list, .content): body
      case (.quoteBlock, .content): body
      case (.callout, .content): body
      case (.strikethrough, .content): strikeText
      case (.highlight, .content): highlight.colourContent
      case (.link, .content): body
      case (.image, .content): body
      case (.horizontalRule, .content): body
        
        /// Syntax characters
      case (.body, .syntaxChar): syntaxCharacters
      case (.heading1, .syntaxChar): syntaxCharacters
      case (.heading2, .syntaxChar): syntaxCharacters
      case (.heading3, .syntaxChar): syntaxCharacters
      case (.heading4, .syntaxChar): syntaxCharacters
      case (.heading5, .syntaxChar): syntaxCharacters
      case (.heading6, .syntaxChar): syntaxCharacters
      case (.bold, .syntaxChar): syntaxCharacters
      case (.italic, .syntaxChar): syntaxCharacters
      case (.boldItalic, .syntaxChar): syntaxCharacters
      case (.inlineCode, .syntaxChar): syntaxCharacters
      case (.codeBlock, .syntaxChar): syntaxCharacters
      case (.list, .syntaxChar): syntaxCharacters
      case (.quoteBlock, .syntaxChar): syntaxCharacters
      case (.callout, .syntaxChar): syntaxCharacters
      case (.strikethrough, .syntaxChar): syntaxCharacters
      case (.highlight, .syntaxChar): highlight.colourSyntaxChar
      case (.link, .syntaxChar): syntaxCharacters
      case (.image, .syntaxChar): syntaxCharacters
      case (.horizontalRule, .syntaxChar): syntaxCharacters
        
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
      case (.inlineCode, .background): inlineCodeBG
      case (.codeBlock, .background): codeBlockBG
      case (.list, .background): nil
      case (.quoteBlock, .background): body
      case (.callout, .background): body
      case (.strikethrough, .background): nil
      case (.highlight, .background): highlight.colourBG
      case (.link, .background): nil
      case (.image, .background): nil
      case (.horizontalRule, .background): nil
    }
  }
}
