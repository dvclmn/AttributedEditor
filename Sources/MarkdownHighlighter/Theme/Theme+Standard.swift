//
//  Theme+Standard.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

//import EditorCore

extension MarkdownTheme {

  public static let `default`: Self = .standard

  public static var standard: Self {
    MarkdownTheme {
      Syntax(.bold) { roles in
        roles[.content] = StyleToken(foreground: .primary, fontTraits: .bold)
      }
      Syntax(.italic) { roles in
        roles[.content] = StyleToken(foreground: .primary, fontTraits: .italic)
        roles[.syntax] = StyleToken(foreground: .tertiary)
      }
      Syntax(.boldItalic) { roles in
        roles[.content] = StyleToken(foreground: .primary, fontTraits: [.bold, .italic])
        roles[.syntax] = StyleToken(foreground: .tertiary)
      }
      Syntax(.link) { roles in
        roles[.content] = StyleToken(foreground: .link)
        roles[.syntax] = StyleToken(foreground: .tertiary)
      }
      Syntax(.codeBlock) { roles in
        roles[.content] = StyleToken(foreground: .secondary, fontTraits: .monoSpace)
        roles[.syntax] = StyleToken(foreground: .gray, fontTraits: .monoSpace)
      }
      Syntax(.inlineCode) { roles in
        roles[.content] = StyleToken(foreground: .brown, fontTraits: .monoSpace)
        roles[.syntax] = StyleToken(foreground: .gray, fontTraits: .monoSpace)
      }
      Syntax(Markdown.Syntax.allHeaders) { roles in
        roles[.content] = StyleToken(foreground: .primary, fontTraits: .bold)
        roles[.syntax] = StyleToken(foreground: .tertiary)
      }
    }
  }

  //      Syntax(.heading1) { roles in
  //        roles[.content] = StyleToken(foreground: .primary, fontTraits: .italic)
  //        roles[.syntax] = StyleToken(foreground: .tertiary)
  //      }

  //      for header in [Markdown.Syntax.heading1, .heading2, .heading3] {
  //  theme.register(header) {
  //    $0.content = StyleToken(foreground: .primary, fontTraits: .bold)
  //    $0.syntax = StyleToken(foreground: .tertiary)
  //  }
}

//      Syntax(.heading1) { roles in
//        roles[.content] = StyleToken(foreground: .primary, fontTraits: .italic)
//        roles[.syntax] = StyleToken(foreground: .tertiary)
//      }
//      Syntax(.heading1) { roles in
//        roles[.content] = .font(.system(size: 22, weight: .bold))
//        roles[.syntax]  = .colour(.accent)
//      }
//    }
//  }

//    var theme = Self()
//
//    theme.register(.bold) {
//      $0.content = StyleToken(foreground: .primary, fontTraits: .bold)
//    }
//    theme.register(.italic) {
//      $0.content = StyleToken(foreground: .primary, fontTraits: .italic)
//      $0.syntax = StyleToken(foreground: .tertiary)
//    }
//    theme.register(.boldItalic) {
//      $0.content = StyleToken(foreground: .primary, fontTraits: [.bold, .italic])
//      $0.syntax = StyleToken(foreground: .tertiary)
//    }
//
//    theme.register(.link) {
//      $0.content = StyleToken(foreground: .link)
//      $0.syntax = StyleToken(foreground: .tertiary)  // "[" and "]"
//      //      $0.url = StyleToken(foreground: .gray)  // (http://...)
//    }
//
//    theme.register(.codeBlock) {
//      $0.content = StyleToken(foreground: .secondary, fontTraits: .monoSpace)
//      //      $0.languageHint = StyleToken(foreground: .tertiary, fontTraits: .monoSpace)
//      $0.syntax = StyleToken(foreground: .gray, fontTraits: .monoSpace)
//    }
//
//    theme.register(.inlineCode) {
//      $0.content = StyleToken(foreground: .brown, fontTraits: .monoSpace, )
//      $0.syntax = StyleToken(foreground: .gray, fontTraits: .monoSpace)
//      //      $0.background = StyleToken(foreground: .system(.orange, opacity: 0.2), hasBackground: true)
//    }
//
//    //    for header in [Markdown.Syntax.heading1, .heading2, .heading3] {
//    //      theme.register(header) {
//    //        $0.content = StyleToken(foreground: .primary, fontTraits: .bold)
//    //        $0.syntax = StyleToken(foreground: .tertiary)
//    //      }
//    //    }
//
//    return theme
//  }()
//}

