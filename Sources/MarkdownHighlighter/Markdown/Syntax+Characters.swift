//
//  Syntax+Characters.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

extension Markdown.Syntax {

  public var leadingCharacter: Character? {
    switch self {
      case .heading:
        return "#"

      case .bold, .italic, .boldItalic:
        return "*"

      case .inlineCode:
        return "`"
      case .highlight:
        return "="
      case .strikethrough:
        return "~"
      default:
        return nil

    }
  }

  public var trailingCharacter: Character? {
    switch self {
      case .heading:
        return "\n"

      case .bold, .italic, .boldItalic, .inlineCode, .highlight, .strikethrough:
        /// These are 'symmetrical' syntaxes, so their leading and trailing characters will be the same
        return self.leadingCharacter

      default:
        return nil
    }
  }

  public var leadingCharacterCount: Int? {
    switch self {
      case .heading(let level): level
      case .bold, .strikethrough, .highlight:
        2
      case .italic, .inlineCode:
        1
      case .boldItalic:
        3

      default:
        nil
    }
  }

  public var trailingCharacterCount: Int? {
    switch self {
      case .heading(let level): level
      case .bold, .strikethrough, .highlight:
        2
      case .italic, .inlineCode:
        1
      case .boldItalic:
        3

      default:
        nil
    }
  }

}
