//
//  Theme+Standard.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

extension Markdown.Theme {
  
  public static let `default`: Self = .standard
  
  public static let standard: Self = {
    var theme = Self()
    
    theme.register(.bold) {
      $0.content = TokenStyle(colour: .primary, font: .bold)
      $0.syntax = TokenStyle(colour: .tertiary)
    }
    theme.register(.italic) {
      $0.content = TokenStyle(colour: .primary, font: .italic)
      $0.syntax = TokenStyle(colour: .tertiary)
    }
    theme.register(.boldItalic) {
      $0.content = TokenStyle(colour: .primary, font: [.bold, .italic])
      $0.syntax = TokenStyle(colour: .tertiary)
    }
    
    // Split case: Header
    theme.register(.heading1) {
      $0.content = TokenStyle(colour: .primary, font: .bold)
      $0.leading = TokenStyle(colour: .orange) // Only setting leading
    }
    
    // Metadata case: Link
    /// We use the `.url` alias, which saves to `.metadata`
    theme.register(.link) {
      $0.content = TokenStyle(colour: .link)
      $0.syntax = TokenStyle(colour: .tertiary) // [ and ]
      $0.url = TokenStyle(colour: .gray) // (http://...)
    }
    
    // Metadata case: Code Block
    /// We use the `.languageHint` alias, which also saves to `.metadata`
    theme.register(.codeBlock) {
      $0.content = TokenStyle(font: .monoSpace)
      $0.languageHint = TokenStyle(colour: .secondary) // "swift"
    }
    
    theme.register(.inlineCode) {
      $0.content = TokenStyle(font: .monoSpace)
      $0.leading = TokenStyle(colour: .orange)
//      $0.syntax = TokenStyle(colour: .tertiary)
      $0.background = .gray
    }
    
    return theme
  }()
}

//extension Theme {
//  static let standard: Theme = {
//    var theme = Theme()
//    
//    // Grouped definition for Inline Code
//    theme.register(.inlineCode) {
//      $0.content = TokenStyle(color: .systemPink, fontTraits: .monoSpace)
//      $0.syntax = TokenStyle(color: .gray)
//      $0.background = NSColor.gray.withAlphaComponent(0.2)
//    }
//    
//    // Grouped definition for Links
//    theme.register(.link) {
//      $0.content = TokenStyle(color: .systemBlue)
//      $0.syntax = TokenStyle(color: .systemGray)
//      $0.tint = TokenStyle(color: .systemTeal) // Maps to .url automatically
//    }
//    
//    // Grouped definition for Headers
//    // You can even loop here to keep it DRY
//    for header in [Markdown.Syntax.heading1, .heading2, .heading3] {
//      theme.register(header) {
//        $0.content = TokenStyle(color: .labelColor, fontTraits: .bold)
//        $0.syntax = TokenStyle(color: .tertiaryLabelColor)
//      }
//    }
//    
//    return theme
//  }()
//}
