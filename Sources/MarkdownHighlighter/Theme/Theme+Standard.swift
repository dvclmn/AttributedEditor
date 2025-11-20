//
//  Theme+Standard.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

extension Theme {
  static let standard: Theme = {
    var theme = Theme()
    
    // Grouped definition for Inline Code
    theme.register(.inlineCode) {
      $0.content = TokenStyle(color: .systemPink, fontTraits: .monoSpace)
      $0.syntax = TokenStyle(color: .gray)
      $0.background = NSColor.gray.withAlphaComponent(0.2)
    }
    
    // Grouped definition for Links
    theme.register(.link) {
      $0.content = TokenStyle(color: .systemBlue)
      $0.syntax = TokenStyle(color: .systemGray)
      $0.tint = TokenStyle(color: .systemTeal) // Maps to .url automatically
    }
    
    // Grouped definition for Headers
    // You can even loop here to keep it DRY
    for header in [Markdown.Syntax.heading1, .heading2, .heading3] {
      theme.register(header) {
        $0.content = TokenStyle(color: .labelColor, fontTraits: .bold)
        $0.syntax = TokenStyle(color: .tertiaryLabelColor)
      }
    }
    
    return theme
  }()
}
