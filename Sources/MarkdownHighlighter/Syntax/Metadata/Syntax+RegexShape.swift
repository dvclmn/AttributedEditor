//
//  Syntax+RegexShape.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 19/11/2025.
//


extension Markdown.Syntax {
  
  var supportsRegexShape: Bool {
    switch self {
      case .body, .list, .callout: false
      default: true
    }
  }
  
  var shapeKind: RegexShape {
    switch self {
      case .heading1, .heading2, .heading3, .heading4, .heading5, .heading6:
          .prefix
        
      case .bold, .italic, .boldItalic, .inlineCode, .strikethrough, .highlight:
          .wrap
        
      case .codeBlock:
          .codeBlock
        
      case .quoteBlock:
          .linePrefix
        
      case .link, .image:
          .wrapPair
        
      case .horizontalRule:
          .single
        
      case .body, .list, .callout:
        fatalError("\(self.name) not yet supported.")
    }
  }
}
