//
//  Theme+Standard.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 20/11/2025.
//

extension MarkdownTheme {
  public static let `default`: Self = .standard

  public static var standard: Self {
    MarkdownTheme {
      
      Syntax(.bold) { roles in
        roles.set(.content, style: StyleToken(colour: .primary, font: .bold))
      }

      Syntax(.italic) { roles in
        roles.set(.content, style: StyleToken(colour: .primary, font: .italic))
      }

      Syntax(.boldItalic) { roles in
        roles.set(.content, style: StyleToken(colour: .primary, font: [.bold, .italic]))
      }

      Syntax(.link) { roles in
        roles.set(.content, style: StyleToken(colour: .link))
      }

      Syntax(.codeBlock) { roles in
        roles.set(.content, style: StyleToken(colour: .secondary, font: .monoSpace))
      }

      Syntax(.inlineCode) { roles in
        roles.set(.content, style: StyleToken(colour: .brown, font: .monoSpace, fontScale: 0.94))
      }

      Syntax(.highlight) { roles in
        roles.set(.content, style: StyleToken(colour: .blue))
        roles.set(.syntax, style: StyleToken(colour: .cyan))
      }

      Syntax(.strikethrough) { roles in
        roles.set(.content, style: StyleToken(colour: .gray, decoration: .default))
//        roles.set(.syntax, style: StyleToken(colour: .red, font: .monoSpace))
      }

      Syntax(Markdown.Syntax.allHeaders) { roles in
        roles.set(.content, style: StyleToken(colour: .primary, font: .bold))
        roles.set(.syntax, style: StyleToken(colour: .tertiary))
      }
    }
  }
}
