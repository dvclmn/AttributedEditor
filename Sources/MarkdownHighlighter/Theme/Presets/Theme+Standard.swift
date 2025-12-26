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

    theme.register(.link) {
      $0.content = StyleToken(colour: .link)
      $0.syntax = StyleToken(colour: .tertiary)  // "[" and "]"
      $0.url = StyleToken(colour: .gray)  // (http://...)
    }

    theme.register(.codeBlock) {
      $0.content = StyleToken(colour: .secondary, fontTraits: .monoSpace)
      $0.languageHint = StyleToken(colour: .tertiary, fontTraits: .monoSpace)
      $0.syntax = StyleToken(colour: .gray, fontTraits: .monoSpace)
    }

    theme.register(.inlineCode) {
      $0.content = StyleToken(colour: .brown, fontTraits: .monoSpace, )
      $0.syntax = StyleToken(colour: .gray, fontTraits: .monoSpace)
      $0.background = StyleToken(colour: .system(.orange, opacity: 0.2), hasBackground: false)
    }

    for header in [Markdown.Syntax.heading1, .heading2, .heading3] {
      theme.register(header) {
        $0.content = StyleToken(colour: .primary, fontTraits: .bold)
        $0.syntax = StyleToken(colour: .tertiary)
      }
    }

    return theme
  }()
}
