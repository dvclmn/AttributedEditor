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
    
    // 1. Simple case: Bold
    // Uses `.syntax` to set both leading (**) and trailing (**) at once
    theme.register(.bold) {
      $0.content = TokenStyle(color: .labelColor, fontTraits: .bold)
      $0.syntax = TokenStyle(color: .tertiaryLabelColor)
    }
    
    // 2. Split case: Header
    // Headers usually have leading syntax (#) but no trailing syntax
    theme.register(.heading1) {
      $0.content = TokenStyle(color: .labelColor, fontTraits: .bold)
      $0.leading = TokenStyle(color: .systemOrange) // Only setting leading
    }
    
    // 3. Metadata case: Link
    // We use the `.url` alias, which saves to `.metadata`
    theme.register(.link) {
      $0.content = TokenStyle(color: .linkColor)
      $0.syntax = TokenStyle(color: .tertiaryLabelColor) // [ and ]
      $0.url = TokenStyle(color: .systemGray) // (http://...)
    }
    
    // 4. Metadata case: Code Block
    // We use the `.languageHint` alias, which also saves to `.metadata`
    theme.register(.codeBlock) {
      $0.content = TokenStyle(fontTraits: .monoSpace)
      $0.languageHint = TokenStyle(color: .secondaryLabelColor) // "swift"
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
