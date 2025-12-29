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
        roles.set(.syntax, style: StyleToken(colour: .tertiary))
      }

      Syntax(.boldItalic) { roles in
        roles.set(.content, style: StyleToken(colour: .primary, font: [.bold, .italic]))
        roles.set(.syntax, style: StyleToken(colour: .tertiary))
      }

      Syntax(.link) { roles in
        roles.set(.content, style: StyleToken(colour: .link))
        roles.set(.syntax, style: StyleToken(colour: .tertiary))
      }

      Syntax(.codeBlock) { roles in
        roles.set(.content, style: StyleToken(colour: .secondary, font: .monoSpace))
        roles.set(.syntax, style: StyleToken(colour: .gray, font: .monoSpace))
      }

      Syntax(.inlineCode) { roles in
        roles.set(.content, style: StyleToken(colour: .brown, font: .monoSpace))
        roles.set(.syntax, style: StyleToken(colour: .gray, font: .monoSpace))
      }

      Syntax(Markdown.Syntax.allHeaders) { roles in
        roles.set(.content, style: StyleToken(colour: .primary, font: .bold))
        roles.set(.syntax, style: StyleToken(colour: .tertiary))
      }
    }
  }
}
