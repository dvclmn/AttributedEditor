//
//  Theme+Standard.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

extension Markdown.Theme {

  public static let `default`: Self = .standard

  /// Note: The syntax default colour is `.tertiary`,
  /// which is what I want here, so it is skipped in most cases
  ///
  /// Theme gets built over here
  public static let standard: Self = {
    var theme = Self()

    theme.register(.bold) {
      $0.content = StyleToken(colour: .primary, fontTraits: .bold)
    }
    theme.register(.italic) {
      $0.content = StyleToken(colour: .primary, fontTraits: .italic)
      $0.syntax = StyleToken(colour: .tertiary)
    }
    theme.register(.boldItalic) {
      $0.content = StyleToken(colour: .primary, fontTraits: [.bold, .italic])
      $0.syntax = StyleToken(colour: .tertiary)
    }

    /// Split case: Header
    theme.register(.heading1) {
      $0.content = StyleToken(colour: .primary, fontTraits: .bold)
    }

    /// Metadata case: Link
    /// We use the `.url` alias, which saves to `.metadata`
    theme.register(.link) {
      $0.content = StyleToken(colour: .link)
      $0.syntax = StyleToken(colour: .tertiary)  // [ and ]
      $0.url = StyleToken(colour: .gray)  // (http://...)
    }

    // Metadata case: Code Block
    /// We use the `.languageHint` alias, which also saves to `.metadata`
    theme.register(.codeBlock) {
      $0.content = StyleToken(colour: .secondary, fontTraits: .monoSpace)
      $0.languageHint = StyleToken(colour: .tertiary, fontTraits: .monoSpace)
      $0.syntax = StyleToken(colour: .gray, fontTraits: .monoSpace)
    }

    theme.register(.inlineCode) {
      $0.content = StyleToken(colour: .brown, fontTraits: .monoSpace, )
      $0.syntax = StyleToken(colour: .gray, fontTraits: .monoSpace)

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
//      $0.content = StyleToken(color: .systemPink, fontTraits: .monoSpace)
//      $0.syntax = StyleToken(color: .gray)
//      $0.background = NSColor.gray.withAlphaComponent(0.2)
//    }
//
//    // Grouped definition for Links
//    theme.register(.link) {
//      $0.content = StyleToken(color: .systemBlue)
//      $0.syntax = StyleToken(color: .systemGray)
//      $0.tint = StyleToken(color: .systemTeal) // Maps to .url automatically
//    }
//
//    // Grouped definition for Headers
//    // You can even loop here to keep it DRY
//    for header in [Markdown.Syntax.heading1, .heading2, .heading3] {
//      theme.register(header) {
//        $0.content = StyleToken(color: .labelColor, fontTraits: .bold)
//        $0.syntax = StyleToken(color: .tertiaryLabelColor)
//      }
//    }
//
//    return theme
//  }()
//}
